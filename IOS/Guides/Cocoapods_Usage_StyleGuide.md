## Версионирование

Все версии pods не имеют версий в podfile. Механизм версионирования pods осуществляется через `Podfile.lock`. Он **не должен находиться в .gitignore** проекта

## Общий вид podfile

```swift
source "https://github.com/CocoaPods/Specs.git"
source "https://github.com/TouchInstinct/Podspecs.git"

inhibit_all_warnings!
platform :ios, '11.0'
use_frameworks!

project 'MyProject', {
    'StandardDebug' => :debug,
    'StandardRelease' => :release,
    'EnterpriseDebug' => :debug,
    'EnterpriseRelease' => :release,
    'AppStore' => :release,
}

target "MyProject" do
    pod 'Alamofire'
end
```

## Команда для обновления pods

Самая простая команда для обновления cocoapods:

```sh
pod install
```

Если нет времени ждать обновления метаданных репозитория cocoapods:

```sh
pod install --no-repo-update
```

Если хочется позалипать в терминал пока устанавливаются поды:

```sh
pod install --no-repo-update --verbose
```

Если нужно обновить версию какого-нибудь конкретного фреймворка в проекте:

```sh
pod update Alamofire
```