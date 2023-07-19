# Дистрибуция приложений

В данной статье описаны методы поставки билдов, а также алгоритм выбора варианта поставки и способа её осуществления.

Вариант поставки выбирается в зависимости от целей поставки и типа пользователей, которым нужно поставить (deliver) приложение.

## Цели поставки

- Тестирование изменений (новые фичи, фикс багов)
- Тестирование фичей в окружении конечных пользователей (пуши, оплата, миграция)
- Демо клиенту
- Приёмка работ клиентом
- Релиз в магазин приложений

## Типы пользователей

- Команда проекта (тестировщики, PM, etc.)
- Клиенты
- Конечные пользователи

## Варианты поставки 

1. Через стороннюю платформу дистрибуции приложений (fabric, hockey app, etc.)
2. Локальная (установка разработчиком на девайс)
3. Через тестовые платформы вендора ОС (TestFlight, Play Console)
4. Через магазин приложений (AppStore, Google Play)

## Матрица выбора способа поставки

|Цель / Пользователь|Команда проекта|Клиент|Конечный пользователь|
|:-:|:-:|:-:|:-:|
|Тестирование|Fabric, Local|-|-|
|Тестирование в живом окружении|TestFlight, Play Console|-|-|
|Демо|Fabric|-|-|
|Приёмка работ|-|Fabric|-|
|Релиз в магазин|-|-|App Store, Google Play|

**Примечание**: Может потребоваться предоставить клиенту возможность самостоятельно проводить тестирование. Тогда поставка будет аналогична поставке для команды проекта.

## Как осуществить поставку приложения

### Поставка через Fabric

Осуществляется разработчиком путём запуска сборки с определённой конфигурацией и флагом UPLOAD\_TO\_FABRIC на CI (TeamCity):

- [Android TeamCity](http://10.0.7.3:8111)
- [iOS TeamCity](http://10.0.7.4:8111)

**Примечание**: Конфигурации по умолчанию для каждого проекта описаны в [гугло табличке](https://docs.google.com/spreadsheets/d/1_-kWN4ZB9VvHIV1Iitx49JM_kt7VNA9k2tnBE4xY410). Они определяются тестировщиком на проекте.

**Важно**: **Загружать билды в Fabric в обход CI запрещено!** Из этого следует, что если билд сервер не работает - **билд заказчику не отдается. Передача билда заказчику в обход отдела тестирования запрещена.**

После успешной сборки и загрузки сборки в Fabric разработчик должен сообщить тестировщику номер сборки и краткий список изменений с момента предыдущей поставки.

**Примечание №2**: За работоспособность CI отвечает CTO и Team Lead платформы. В случае неработоспособности CI, разработчик обязан донести эту информацию до отвественных лиц. В случае проблем со сборками на проекте разработчик должен предпринять все возможные действия направленные на восстановление работоспособности сборок. 


### Локальная поставка

Осуществляется **только** в случае невозможности осуществить поставку сборки для команды проекта через CI.

Для осуществления такого рода поставки разработчику необходимо взять все устройства у тестировщика, на которые необходимо установить приложение и загрузить на них приложение с необходимой для тестирования конфигурацией через среду разработки.

### Поставка через TestFlight / Play Console

Осуществляется по аналогии с поставкой в магазин приложений с тем лишь отличием, что после загрузки необходимо выбрать специальный тип распространения в консоли разработчика.

После успешной сборки и загрузки сборки в TestFlight / Play Console разработчик должен сообщить тестировщику номер сборки.

### Поставка через App Store / Google Play

Осуществляется разработчиком по аналогии с поставкой через Fabric (с флагом UPLOAD\_TO\_STORE), либо в ручном или полуавтоматическом режиме (fastlane) со своего ПК.

**Важно**: выкладка сборки в магазин приложений в обход отдела тестирования запрещена!