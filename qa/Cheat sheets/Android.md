# Android

## Ссылки

- [Статья про тестирование андроид от Саши Савицкой](https://habrahabr.ru/company/mobileup/blog/327416/)
- [Как подобрать андроид-девайсы для тестирования](https://habrahabr.ru/company/badoo/blog/317964/)
- Про ADB
    - [на 4pda](http://4pda.ru/forum/index.php?showtopic=383300)
    - [developer.android.com](https://developer.android.com/studio/command-line/adb.html)
- [Манки-тест андроид](http://developer.android.com/tools/help/monkey.html)
- [Запись видео андроид](http://www.4tablet-pc.net/reviews-a-articles/4254-android-4-4-screenrecord.html)
- [Если ddms не увидел девайс -- установка usb-driver](http://chizi.by/%D0%B5%D1%81%D0%BB%D0%B8-ddms-%D0%BD%D0%B5-%D0%B2%D0%B8%D0%B4%D0%B8%D1%82-adb-devices-%D0%B2-eclipse/)
- [Как поставить сервисы Google Play на эмулятор (genymotion)](https://gist.github.com/wbroek/9321145)
- [Google Cloud Messaging for Android](https://developers.google.com/cloud-messaging/gcm)
- [Презентация про Андроид от Леши](https://docs.google.com/presentation/d/1wvIU4VWFBdN1PfDS-YeSoV8fFYBzqDzHrmGPnq4ZoyQ/edit#slide=id.p4)
    - [mindmap](https://drive.mindmup.com/map/0B-5ugUAucKhCY1Z1MmhGUVRXNkU)
- [Презентация про Андроид от Касперского](https://docs.google.com/presentation/d/1t1Qbl5sEp8PukrpVVOXsHULJ-8n5rbhwit5oQBKpVlA/edit)
- [Статья про утечки памяти от Даши](https://habrahabr.ru/company/touchinstinct/blog/330284/)

## Шпоргалки

#### Как стать андроид-разработчиком
в настройках девайса → об устройстве → номер сборки 
- затапать 7 раз

#### Тестирование с установленной настройкой “don’t keep activities”
В андроиде все запущенные приложения представлены в виде activities. 
На приложения выделяется достаточно мало памяти, поэтому система будет периодически выгружать приложения из памяти по собственным установленным приоритетам. 
В результате, пользователь может потерять важные данные в таком случае, либо приложение может крашнуться. В этом случае важно уделять внимание тестированию с установленной галкой “don’t keep activities” (настройки – для разработчика). Эта настройка эмулирует недостаток памяти – при каждом скрытии активити она будет умирать и должна корректно восстанавливаться после возвращения ее на экран. 
Во время тестирования надо акцентрировать внимание на экранах с loading’ами, экранах с полями редактирования.

#### FAB
проверять сокращение списка в нижней позиции скролла когда FAB скрыта -- она может не появиться






