# Управление аккаунтом разработчика

В данном гайде описан процесс добавления приложения в Apple Developer аккаунты apple и его дальнейшая настройка.


## Содержание

- [Создание AppID](#Создание-AppID)
- [Создание Provision Profiles](#Создание-provision-profiles)
- [Добавление Push Certificates](#Добавление-push-certificates)
- [Создание AppGroups](#Создание-appGroups)
- [Добавление поддержки Apple Pay](#Добавление-поддержки-apple-pay)


## Создание AppID

1. В аккаунте разработчика перейти в "Certificates, Identifiers & Profiles"
2. Выбрать пункт меню "Identifiers"
3. Нажать кнопку "+", выбрать "App IDs" на странице "Register a New Identifier" и нажать кнопку "Continue"
4. Запонить поля:
	1. Description (указать название приложения в формате MyAppName)
	2. Bundle ID (указать название приложения в формате hyphen-case). Bundle ID должен быть Explicit.
		1. Для **development** аккаунта формат - `ru.touchin.my-app-name`
		2. Для **enterprise** аккаунта формат - `com.touchin.my-app-name`
		3. Для **app store** аккаунта чёткого формата нет, но желательными является форматы - `customer.domain.my-app-name` или `customer.domain.mobile`
	3. Выбрать необходимые capabilities (App Groups, Apple Pay Payment Processing, Push Notifications, etc.)
5. Готово!


## Создание Provision Profiles

1. На странице "Certificates, Identifiers & Profiles" выбрать пункт меню "Profiles"
2. Нажать кнопку "+", выбрать "iOS App Development" для для **development** аккаунта и "In House" для **enterprise** на странице "Register a New Provisioning Profile" и нажать кнопку "Continue"
3. Выбрать App ID для которого нужно создать provision profile и нажать кнопку "Continue"
4. Выбрать самый свежий сертификат и нажать кнопку "Continue"
	1. Для **development** аккаунта - `Apple Apple (iOS Development)`
	2. Для **enterprise** аккаунта - `Touch Instinct OOO (iOS Distribution)`
	3. Для **app store** аккаунта - смотреть по ситуации
5. В поле "Provisioning Profile Name".
	1. Для **development** аккаунта формат - MyAppNameStandardProfile
	2. Для **enterprise** аккаунта формат - MyAppNameEnterpriseProfile
	3. Для **app store** аккаунта формат - MyAppNameAppStoreProfile
	4. Если название не помещается в 50 символов, нужно проявить смекалку и назвать в несколько ином формате (например UBRDNotificationServiceExtensionEnterprise).
6. Нажать кнопку "Generate" и скачать сгенерированный profile
7. Готово!

**Примечание**: Профайлы для **development** и **app store** аккаунтов можно создать через команду [fastlane SyncCodeSigning](Fastlane_cheat_sheet.md).


## Добавление Push Certificates

1. На странице "Certificates, Identifiers & Profiles" выбрать пункт меню "Certificates"
2.  Нажать кнопку "+", выбрать "Apple Push Notification service SSL (Sandbox & Production)" на странице "Create a New Certificate" и нажать кнопку "Continue"
3. Выбрать App ID для которого нужно создать пуш сертификат и нажать кнопку "Continue"
4. Открыть приложение Keychain Access на маке и через меню выбрать пункт "Request a Certificate From a Certificate Authority" (Keychain Access > Certificate Assistant > Request a Certificate From a Certificate Authority)
5. Заполнить поля ввода:
	1. User Email Address (формат: your.name@touchin.ru)
	2. Common Name
		1. Для **development** аккаунта формат MyAppNameStandardPushCertificate 
		2. Для **enterprise** аккаунта формат MyAppNameEnterpriseAppStorePushCertificate 
		3. Для **app store** аккаунта формат MyAppNameAppStorePushCertificate
	3. Request is выбрать "Saved to disk"
6. Сохранить файл на диск, выбрать его на странице "Create a New Certificate" и нажать "Continue"
7. Сгенерированный cer файл скачать и открыть. Он будет добавлен в Keychain Access
8. В Keychain Access в панели "Keychains" выбрать login keychain, а в панели "Category" выбрать "My Certificates".
9. Найти элемент с названием "Apple Push Services: your.app.bundle.id", раскрыть его и в контекстном меню самого ключа выбрать пункт "Export ..."
10. Сохранить ключ в формате p12 и именем совпадающим с тем, что был указан в Common Name (п. 5.2)
11. Готово!

**Примечание**: Пуш сертификаты для **development** и **app store** аккаунтов можно создать через команду [fastlane CreatePushCertificate](Fastlane_cheat_sheet.md#Генерация-пуш-сертификатов).

## Создание AppGroups

Для обмена данными между виджетами, расширениями и основным приложением необходимо настроить app group (также это бывает необходимо для обмена данными между независимыми приложениями).

### Создание группы

1. На странице "Certificates, Identifiers & Profiles" выбрать пункт меню "Identifiers"
2.  Нажать кнопку "+", выбрать "App Groups" на странице "Register a New Identifier" и нажать кнопку "Continue"
3. Заполнить поля:
	1. Description (формат: MyAppNameGroup)
	2. Identifier
		1. Для **development** аккаунта формат - `group.ru.touchin.my-app-name`
		2. Для **enterprise** аккаунта формат - `group.com.touchin.my-app-name`
		3. Для **app store** аккаунта чёткого формата нет, но желательным является формат - `group.customer.domain.my-app-name`
4. Готово!

### Привязка группы к идентификаторам приложений

1. На странице "Certificates, Identifiers & Profiles" выбрать пункт меню "Identifiers"
2. Для каждого идентификатора, который нужно привязать к группе выполнить следующие действия:
	1. Открыть страницу редактирования идентификатора приложения "Edit your App ID Configuration"
	2. Поставить галку "enabled" напротив App Groups capability (если не стоит)
	3. Перейти в редактирование App Groups capability
	4. В появившемся окне "App Group Assignment" выбрать идетификаторы групп к которым нужно привязать идентификатор приложения и нажать "Continue"
3. Готово!

## Добавление поддержки Apple Pay

**Примечание**: Apple Pay **недоступен** для **enterprise** аккаунта.

### Создание Merchant IDs

1. На странице "Certificates, Identifiers & Profiles" выбрать пункт меню "Identifiers"
2. Нажать кнопку "+", выбрать "Merchant IDs" на странице "Register a New Identifier" и нажать кнопку "Continue"
3. Заполнить поля:
	1. Description (формат: MyAppNameMerchant)
	2. Identifier
		1. Для **development** аккаунта формат - `merchant.ru.touchin.my-app-name`
		2. Для **app store** аккаунта формат - `merchant.customer.domain.my-app-name`
4. Готово!

### Привязка Merchant ID к идентификаторам приложений

1. На странице "Certificates, Identifiers & Profiles" выбрать пункт меню "Identifiers"
2. Для каждого идентификатора, который должен работать с мерчантами выполнить следующие действия:
	1. Открыть страницу редактирования идентификатора приложения "Edit your App ID Configuration"
	2. Поставить галку "enabled" напротив Apple Pay Payment Processing (если не стоит)
	3. Перейти в редактирование Apple Pay Payment Processing capability
	4. В появившемся окне "Merchant ID Assignment" выбрать идетификаторы мерчантов к которым нужно привязать идентификатор приложения и нажать "Continue"
3. Готово!


**Важно**: после включения/отключения любых capabilities необходимо перегенерировать provision profile для app id, в котором были внесены изменения.