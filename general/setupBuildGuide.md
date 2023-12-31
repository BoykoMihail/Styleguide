# CI и BuildServer

*Кратко ознакомиться с тем, что такое CI и его основными принципами, можно, например, [тут](https://medium.com/southbridge/ci-cd-принципы-внедрение-инструменты-f0626b9994c8) или [тут](https://ru.wikipedia.org/wiki/Непрерывная_интеграция).*

## Что такое BuildServer и зачем он нужен

**BuildServer** позволяет собирать приложения из исходного кода для передачи в тестирование, поставки заказчику или выдачи в стор. BuildServer основан на [TeamCity](https://www.jetbrains.com/ru-ru/teamcity/). BuildServer включает в себя 2 [агента](https://www.jetbrains.com/help/teamcity/build-agent.html): один – для ручных сборок, второй – для автоматических сборок, инициируемых при создании MR.

Ссылки на BuildServer  
* для Android-проектов – http://android.teamcity.ti  
* для iOS-проектов – http://ios.teamcity.ti  
* для Web-проектов и документации – http://web.teamcity.ti/

По этим ссылкам можно поставить сборку приложения.
<img width="1366" alt="image" src="https://user-images.githubusercontent.com/25684167/75229550-32c17580-57c3-11ea-98c4-bbaa8ff0df14.png">

## Параметры конфигурации сборки

**OBFUSCATE (только Android)** – определяет наличие обфускации исходного кода

Возможные параметры:

* `Obfuscate`
* `NoObfuscate`

**Важно отметить**, что необфусцированная сборка должна собираться только в особых слуаях, например по требованию заказчика. Во всех остальных случаях необходимо собирать с обфускацией. Тестирование на необфусцированных сборках запрещено.

**SERVER_TYPE** - определяет, на чьей стороне развернуто API

Возможные параметры:

* `Mock`
* `Touchin`
* `Customer`


**SERVER_ENVIRONMENT** - определяет среду, на которой развернуто API

Возможные параметры:

| Название среды | Описание среды	| Используется с `SERVER_TYPE`	|
|---	           |---             |---                            |
| `Dev`          | Среда для разработчиков, тут самая последняя версия мидла |`Mock`<br>`Touchin` |  
| `Test`         | Среда для тестировщиков, основное тестирование должно происходить на этой сборке | `Touchin` |
| `Stage`        | Сборка, которая смотрит на копию прода | `Touchin`<br>`Mock`, если сборку показывают заказчику на моке |
| `Prod`         | Сборка, которая смотрит на прод | `Customer` |

**SSL_PINNING** - включает/отключает SSL-pinning

Возможные параметры:

* `WithSSLPinning`
* `WithoutSSLPinning`

**TEST_PANEL** - определяет доступность тестовых инструментов

Возможные параметры:

* `WithTestPanel`
* `WithoutTestPanel`

**BUILD_TYPE (только Android)** - определяет тип сборки

Возможные параметры:

* `Debug`
* `Release`

**Важно отметить**, что Debug сборка должна собираться только в особых слуаях, например по требованию заказчика. Во всех остальных случаях необходимо собирать Release. Тестирование на Debug сборках запрещено.

## Правила задания конфигурации:

1. Название конфигурации составляется из представленных выше значений в том порядке, в котором они указаны.

    Например:

    `ObfuscateCustomerProdWithSSLPinningWithoutTestPanelRelease` для Android  
    `CustomerProdWithSSLPinningWithoutTestPanelRelease` для iOS –  
    API смотрит на API заказчика, которое развернуто в продакшн-среде. Сборка со включенным SSL-pinning и с отключенными тестовыми инструментами.

2. Необязательно наличие адресов API для всех возможных комбинаций на проекте `SERVER_TYPE` и `SERVER_ENVIRONMENT`. Сборка упадет при выборе несуществующей конфигурации. Возможные комбинации должны быть описаны в wiki common-репозитория проекта.


## Дополнительные параметры

* **UPLOAD_TO_FABRIC** - флаг, позволяющий загружать приложение в fabric
* **UPLOAD_TO_STORE** - флаг, позволяющий загружать приложение в store. На iOS сборка загружается в TestFlight, а на Android в альфа-тестирование Google Play.

  **Важно отметить**, что сборка с указанными флагом возможна только с ветки master или из созданного в эту ветку Merge Request. Если набор параметров конфигурации отличается от того, который необходим для сторовской сборки, то процесс сборки завершится ошибкой.

* **CUSTOM_ENDPOINT** - позволяет указать кастомный адрес для API, с которым взаимодействует приложение

  **Важно отметить**, что данный параметр нельзя указать для сторовской сборки, иначе процесс сборки завершится ошибкой.

## Автоматическая сборка при создании Merge Request

Сборка запускается автоматически при создании MR в следующие ветки:

* master
* develop
* release/*
* feature/*

Успешная сборка является обязательным условием для возможности смержить MR.  

**Важно отметить**, что после создания MR сборка будет запускаться при каждом новом коммите в рамках этого MR. Это способствует увеличению загрузки рабочего ресурса BuildServer-а. Поэтому настоятельно рекомендуется создавать MR с уже законченным для прохождения Code Review решением и воздерживаться от дополнения его новыми коммитами.
  
**Важно отметить для Android**, что сборка, запущенная при создании MR, включает в себя стадию Static Analysis. Если Static Analysis не завершится успешно, то сборка упадет. Поэтому настоятельно рекомендуется прогонять Static Analysis локально до создания MR.

## Артефакты сборки

Успешная сборка содержит доступные для скачивания артефакты.

### Android

* **apk-файл** приложения [в установленном формате](#Глоссарий)  
  Пример: ru.serebryakovas.lukoilmobileapp-3.7.2712-2712-obfuscate-touchinTest-withoutSSLPinning-withoutTestPanel-release.apk
* **aab-файл** приложения при установленном флаге UPLOAD_TO_STORE. [Формат](#Глоссарий) аналогичен apk.
* файл **mapping.txt**, содержащий маппинг деобфусцированных методов и классов на обфусцированные
* файл **release-notes.txt**, содержащий параметры конфигурации сборки


### iOS

* **ipa-файл** приложения [в установленном формате](#Глоссарий)
  Пример: ru.serebryakovas.lukoilmobileapp-3.7.2712-2712-obfuscate-touchinTest-withoutSSLPinning-withoutTestPanel-release.ipa

### Глоссарий

*Формат наименования файла приложения:* {$applicationId}-{$versionName}-{$versionCode}-{$flavourName}




