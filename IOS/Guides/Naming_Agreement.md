# Соглашение об именовании

Необходимо стандартизировать именование аналогичных файлов и пути к ним на всех проектах. Стандартизация поможет снизить порог вхождения для новых разработчиков на проекте, а также избавит от путанницы, связанной с поиском конфигурационных файлов, профайлов и выбором конфигов. Данный гайд поможет вам в этом.

### Содержание

1. [Какие бывают конфиги](#Какие-бывают-конфиги)
2. [Как называть таргеты](#Как-называть-таргеты)
3. [Как называть *bundle_id* (*AppID*) в Dev консоли](#Как-называть-*bundle_id*-(*AppID*)-в-Dev-консоли)
4. [Как называть Provisioning Profile](#Как-называть-Provisioning-Profile)
5. [Как называть сертификаты](#Как-называть-сертификаты)
6. [Как называть `entitlements` файлы и где они должны располагаться в проекте](#Как-называть-`entitlements`-файлы-и-где-они-должны-располагаться-в-проекте)
7. [Как называть конфиги в проекте](#Как-называть-конфиги-в-проекте)


## Какие бывают конфиги

- Standard
- Enterprise
- AppStore

## Как называть таргеты
Если вам необходимо добавить в приложение `App Extension`, то для него нужно добавить новый таргет в проект. При добавлении таргета нужно придерживаться стандартного нейминга:

| Type | Name |
|---|---|
| App Target | `{app_name}` |
| Today Extension | TodayExt |
| Notification Service Extension | NotificationServiceExt |

Если ваш таргет отличен от приведенных в таблице, необходимо назвать его в соответствии с логикой:
	
`Имя Таргета = ТипТаргета` 
	
А также не забыть внести его в данную таблицу.

Для того, чтобы избежать длинных названий, необходимо основной таргет называть так же, как проект в JIRA, например: **Ural Bank for Reconstruction and Development** *(проект)* == **UBRD** *(таргет)*.

## Как называть *bundle_id* (*AppID*) в Dev консоли

Для проекта, который был создан в developer apple account необходимо указать в качестве *bundle_id* `ru.touchin.{ИмяТаргета}`. Например: `ru.touchin.licard`.

Для проекта, который был создан в enterprise apple account необходимо указать в качестве *bundle_id* `com.touchin.{ИмяТаргета}`. Например: `com.touchin.licard`

Если в вашем проекте помимо основного таргета есть дополнительные (виджеты, расширения и тд), то для каждого таргета необходимо придумать *bundle_id* по правилу: `{main_bundle_id}.{ИмяТаргета}`, где `{main_bundle_id}` - идентификатор основного таргета. Например: `ru.touchin.licard.notification-service-ext`

## Как называть Provisioning Profile

Профили для приложения должны именоваться следующим образом:

`Имя Профайла = {ИмяТаргета}{ТипПрофайла}`

Где `{ИмяТаргета}` - название таргета, а `{ТипПрофайла}` можно взять из таблицы:

| ИмяКонфига | ТипПрофайла |
|---|---|
| Standard | Dev |
| Enterprise | InHouse |
| AppStore | AppStore |

Важно помнить, что у названия профайлов есть ограничение в 50 символов, поэтому не нужно ничего добавлять в конец названия. В том случае, если длинна получилась больше 50 символов, нужно обрезать название справа.

Например, есть таргет `SoglasieLK` и нужен профайл для сборки под `Enterprise`, профайл будет иметь такое имя: `SoglasieLK`. Если же ваш таргет имеет длинное название, например `SberbankIncassaciaNotificationServiceExtension`, то имя его профайла обрежется дев консолью до лимита в 50 символов, то есть до `SberbankIncassaciaNotificationServiceExtensionInHo`. Такой проблемы можно избежать, если учитывать требования к названию таргета, описанные [выше](#Как-называть-таргеты).

## Как называть сертификаты

Сертификаты для подписи приложений для разработки или распространения должны называться определенным образом, а именно `{app_name}{AccountType}Cert`, например `SoglasieLKEnterpriseCert`. 

Если вам понадобиться создать сертификат для пушей, то нужно воспользоваться командой **fastlane** для генерации сертификата. Подробнее с генерацией сертифкатов можно ознакомиться [здесь](../CheatSheets/Fastlane_cheat_sheet.md)

**Важно:** название файла должно совпадать с полем *common_name* в сертификате.

## Как называть `entitlements` файлы и где они должны располагаться в проекте

Если в вашем проекте присутствуют `entitlements` файлы, необходимо именовать их в соответствии с логикой:

`ИмяФайла = {ИмяТаргета}{ИмяКонфига}.entitlements`

(Например: `SoglasieLKStandard.entitlements`)

Со всеми возможнами именами конфигов можно ознакомиться в [первом пункте](# Какие бывают конфиги).

Также, необходимо соблюдать соглашение о расположении таких файлов, а именно:

`{КореньПроекта}/{ИмяТаргета}/Resources/{YourEntitlementsFile}`

(Например: `SoglasieLK/SoglasieLK/Resources/SoglasieLKEnterprise.entitlements`)

## Как называть конфиги в проекте

В нашей компании есть замечательный [стайлгайд](../../general/setupBuildGuide.md), в нем каждый желающий может ознакомиться со всеми стандартными конфигами, которые должны быть на каждом проекте. Поэтому необходимо называть конфиги по шаблону:

`ИмяКонфига = {AccountType}{ServerType}{ServerEnvironment}{SSLPinning}{BuildType}`

(Например, если нам нужен конфиг для разработки, то нам подойдет `Debug` сборка с сервером, развернутым внутри компании `Touchin`, причем нам нужен `Dev` сервер, и, конечно, с отключенным пиннингом, итоговое название сборки будет такое: `StandardTouchinDevWithoutSSLPinningDebug`)

Более пордробно можно ознакомиться в [гайде](Xcode_Build_Configurations_Guide.md).

#### Для проектов с конфигами в формате файлов `*.xcconfig`

Еще, в начале каждого конфига должно присутствовать его имя, например `LicardEnterpriseCustomerTestWithoutSSLPinningRelease` (необходимо для различения конфигов для разных таргетов). Также для каждого таргета должен быть один конфиг, отвечающий за релизную сборку. Такой конфиг должен называться:

`ИмяКонфига = {ИмяТаргета}AppStoreRelease` 

(Например: `LicardAppStoreRelease`)