# Настройка конфигураций Xcode

## Параметры конфигурации

Для проекта необходимо создать конфигурации. Рассмотрим основные параметры таких конфигураций. Также рекомендуется ознакомиться с нашим [гайдом](../../general/setupBuildGuide.md) о конфигах внутри компании.

### Параметры:
1. [Debug/Release](##Debug/Release)
2. [WithSSLPinning/WithoutSSLPinning](##WithSSLPinning/WithoutSSLPinning)
3. [Dev/Test/Stage/Prod](##Dev/Test/Stage/Prod)
4. [Mock/Touchin/Customer](##Mock/Touchin/Customer)
5. [Enterprise/Standard](##Enterprise/Standard)
6. [AppStoreRelease](##AppStoreRelease)

### Debug/Release
Параметр **Debug/Release** является дефолтным для любого проекта, определяет тип сборки (для разработки или отправки).

### WithSSLPinning/WithoutSSLPinning
Параметр **WithSSLPinning/WithoutSSLPinning** указывает на то, включен ли [SSL-Pinning](https://www.roxiemobile.ru/blog/ssl-pinning-v-ios-na-swift/) в сборке. 

В том случае, если в проекте (или у конкретного сервера) нет данного метода защиты, ключ все равно должен присутствовать, но может никак не влиять на конечную конфигурацию. Такое решение поможет стандартизировать конфигурации на всех проектах.

### Dev/Test/Stage/Prod
Данный параметр указывает на окружение, на котором развернут сервер (backend или middle).

В том случае, если ваш проект не имеет какого-либо из приведенных серверов (или несколько), необходимо оставить данные конфиги в проекте для стандартизации, рабочие нужно назвать в соотвествии с [гайдом](../../general/setupBuildGuide.md).

Если же, в вашем проекте есть другие типы серверов, помимо стандартных, то количесвто конфигов должно увеличиться ровно на колчиство этих серверов.

### Mock/Touchin/Customer
Помимо окружения, в конфигах нужно указывать на тип сервера, то есть на чьей стороне развернуто API. Подробнее об этом параметре можно прочесть в [гайде](../../general/setupBuildGuide.md).

### Enterprise/Standard
Параметр **Enterprise/Standard** указывает на то, каким сертификатом будет подписан билд. Чаще всего *standard* сертифкат используется для разработки, а *enterprise* для отдачи билдов

### AppStoreRelease
Данная конфигурация выделена из списка и существует только для отдачи билда в стор. Внутри себя она включает **CustomerProdWithSSLPinningRelease**. Должна присутствовать обязательно и только в единственном экземпляре.

## Правило именования конфигурации

Все конфигурациия должны выбирать по одному ключу из каждый группы (исключение составляет [AppStoreRelease](##AppStoreRelease)) и складываться по порядку:

`{ТипСертификата}{ТипСервера}{ОкружениеСервера}{Пиннинг}{ТипСборки}`,

например `EnterpriseCustomerTestWithSSLPinningRelease` для сборки, смотрящий на тестовый сервер, развернутом на стороне заказчика, с включенным SSL-Pinning

или `AppStoreRelease` для сборки в стор.

## Добавление конфигураций в podfile.

Для каждой созданной конфигурации необходимо добавить определение, какую из двух базовых конфигураций должны использовать pods в проекте.

Все конфигурации с окончанием Debug имеют базовую Debug конфигурацию, все конфигурации с окончанием Release имеют Release базовую конфигурацию.

Пример того, что необходимо дописать в podfile.

```ruby
project 'My_Project_Name', {
	...
   'EnterpriseCustomerTestWithSSLPinningDebug' => :debug,
   	...
   'EnterpriseCustomerTestWithSSLPinningRelease' => :release,
   'AppStore' => :release
}
```

## Ключи
Также к каждому конфигу необходимо подключить соответствующие ключи `SWIFT_ACTIVE_COMPILATION_CONDITIONS`. Ключи должны добавляться путем преобразования названия параметра в *uppercase* формат, то есть сделать все буквы заглавными. 

Например, вышеупомянутый конфиг `EnterpriseCustomerTestWithSSLPinningRelease` будет иметь такие ключи:
`ENTERPRISE CUSTOMER TEST WITHSSLPINNING RELEASE`.

## Автоматизация
Для того, чтобы не создавать руками все конфиги (минимум 2 * 2 * 4 * 3 * 2 + 1 = 97 конфигураций!), существует скрипт, генерирующий все конфиги для проекта в формате файлов с расширением `.xcconfig`. Инструкцию по работе скрипта можно найти [здесь](Xcode_Build_Config_Generator.md).