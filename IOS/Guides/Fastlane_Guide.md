# Fastlane

[`Fastlane`](https://docs.fastlane.tools) используется для автоматизации сборки билда на сервере и синхронизации сертификатов и provision profile'ов. Teamcity запускает fastlane скрипт для сборок билдов.

## Доступные возможности

Кроме сборки билда в Firebase, на текущий момент, наши скрипты сборки умеют:

- Отправлять сборки в AppStore (`AppStoreRelease`)
- Синхронизировать сертификаты и provision profile'ы (`SyncCodeSigning`, `ManuallyUpdateCodeSigning`)
- Создавать пуш сертификаты (`CreatePushCertificate`)

Примеры команд можно найти в [fastlane cheat sheet](/IOS/CheatSheets/Fastlane_cheat_sheet.md).

## Настройка

Для корректной работы скриптов необходимо 3 файла:

- Fastfile
- Matchfile
- configurations.yaml

Эти файлы должны располагаться внутри папки `fastlane` в корне проекта.

Также необходимо, чтобы на проекте была настроена [Apple Generic Versioning System](https://developer.apple.com/library/archive/qa/qa1827/_index.html).

### Fastfile

Этот файл импортирует "библиотеку" общих функций и определяет доступные виды сборок и команд для данного проекта в виде так называемых `lanes`.

Для каждой конфигурации в проекте мы создаём одноименную `lane`. Исключением является `AppStore`, для этой конфигурации название lane будет `AppStoreRelease`.

В простейшем случае `lane` будет выглядеть следующим образом:

```
lane :EnterpriseRelease do |options|
  buildConfiguration(options)
end
```
Если нужно передать дополнительные параметры в скрипт, то необходимо добавить их в словарь options:

```
lane :StandardStagingRelease do |options|
    options[:iCloudContainerEnvironment] = "Development"
    buildConfiguration(options)
end
```

#### Используемые _options_ 

_options_ это переменная-словарь с настройками, которые будут использованы в скриптах для управления их поведением.

Большая часть ключей, которые используются в скриптах соотвествует названию параметров в функциях fastlane и передаются туда напрямую (например team_id). Остальные используются в контексте наших скриптов (например uploadToFirebase).

Для полного понимания как используются ключи необходимо изучить файл общих функций [commonFastfile](https://github.com/TouchInstinct/BuildScripts/blob/master/xcode/commonFastfile). 

Далее приведён список параметров, которые настраивают поведение скриптов сбоки:

- _:appName_ - имя приложения (название запускаемой схемы и воркспейса должны совпадать с appName) (строка, по умолчанию - название первого воркспейса). Нужно указывать, если в репозитории несколько проектов (то есть несколько воркспейсов).
- _:buildNumber_ - номер билда (целое число, по умолчанию - 10000)
- _:compileBitcode_ - необходимость компилировать биткод (true/false, по умолчанию - false)
- _:iCloudContainerEnvironment_ - название Container Environment в случае, если в проекте используется Cloudkit (строка, по умолчанию не указывается)
- _:uploadToFirebase_ - необходимость загрузки билда в Firebase (true/false, по умолчанию - false)
- _:uploadToAppStore_ - необходимость загрузки билда в AppStore (true/false, по умолчанию - false)

Например, для запуска сборки #999 конфигурации ConfigurationName проекта MyApp, который лежит в папке ProjectFolder, и последующей его выкладки в Firebase, нужно выполнить команду:

```
cd ProjectFolder && fastlane ConfigurationName buildNumber:999 uploadToFirebase:true appName:MyApp
```

### Matchfile

В данном файле хранятся базовые настройки для утилиты [match](https://docs.fastlane.tools/actions/match/):

- git_url: путь к репозиторию с сертификатами и provision profile'ами
- пароль для расшифровки сертификатов и provision profile'ов

Пример:

```ruby
git_url "git@github.com:TouchInstinct/ProjectName-ios.git"
ENV["MATCH_PASSWORD"] = "********"
```

### configurations.yaml

Данный файл содержит настройки для профилей сборки (appstore, adhoc, development, enterprise).
Для каждого типа сборки определены идентификаторы приложения и идентификаторы apple (dev portal, connect), которые используются в скриптах.

Пример файла configurations.yaml

```yaml
development:
  app_identifier:
  - ru.touchin.projectname
  - ru.touchin.projectname.notification-service-extension
  - ru.touchin.projectname.today-extension
  apple_id: "apple@touchin.ru"
  team_id: "D4HA43V467"
  itc_team_id: "1426360"
enterprise:
  app_identifier:
  - com.touchin.projectname
  - com.touchin.projectname.notification-service-extension
  - com.touchin.projectname.today-extension
  apple_id: "enterpriseapple@touchin.ru"
  team_id: "228J5MMU7S"
appstore:
  app_identifier:
  - ru.customer.domain
  - ru.customer.domain.notification-service-extension
  - ru.customer.domain.widget
  apple_id: "apple@touchin.ru"
  team_id: "**********"
  itc_team_id: "********"
```
