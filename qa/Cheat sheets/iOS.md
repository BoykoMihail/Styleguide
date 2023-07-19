# iOS

## Ссылки
- [Гайдлайны](https://developer.apple.com/ios/human-interface-guidelines/overview/design-principles/)
    - [какой-то перевод на русский](https://medium.com/ios-guidelines-in-russian)
- [Как называется контрол в IOS](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/MobileHIG/Bars.html#//apple_ref/doc/uid/TP40006556-CH12-SW1)
- [Инструмент для тестирования пушей](https://github.com/nomad/houston)

## Шпаргалки
#### Как сбросить разрешение на пуши:
- удалить приложение
- перезапустить девайс
- поставить завтрашнюю дату
- перезапустить девайс
- поставить сегодняшнюю дату
- перезапустить девайс
- поставить приложение

#### Как подключить почту на устройстве
- Зайти в настройки
- Перейти в “Почта, адреса, календари”
- Тапнуть “Добавить учетную запись”
- В списке тапнуть на “Другое”
- Тапнуть “Новая учетная запись”
- Заполнить все поля, нажать “Далее”
- В секции “Сервер входящей почты”  поле “Имя узла” = imap.yandex.ru (наша корпоративная почта)
- В секции “Сервер входящей почты”  в поле “Имя польз.” ввести свой ящик
- В секции “Сервер исходящей почты”  поле “Имя узла” = smtp.yandex.ru
- Нажать “Далее”

#### Как узнать UDID устройства
Можно посмотреть в ITunes (щелчкнуть мышью на серийном номере - появится UDID)


#### Provision profile 
Конфигурационный файл, в котором хранится список с UDID'ами устройств. На устройство невозможно установить тестовое приложение, если в Provision profile нет UDID устройства.


#### TestFlight
Инструмент для распространения сборок на beta-тестирование. Загрузка в AppStor идет прямо из TestFlight. 

