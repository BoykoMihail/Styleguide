# iOS share extension intro

Прежде всего нужно отделить <s>зерна от плевел</s> код, который будет компилиться для share extension от `UIApplication`.

Дело в том, что `UIApplication.shared` не доступен расширениям приложений. На практике это означает невозможность показать `networkActivityIndicator` и указать конкретный `statusBarStyle`. Кстати, по поводу стиля статус бара есть даже [радар](http://openradar.appspot.com/radar?id=6397505050771456) (всё ещё открыт на 24/04/2017).

## Pre code

Расширение имеет свой `bundleId` вида `<AppBundleId>.ExtensionName`, например: `com.touchin.Chat.ShareExtension`. Это значит что расширению также потребуется провижен профайл (или даже два - не забываем про enterprise аккаунт).

Но не торопитесь создавать провижены: скорее всего расширению будет нужно иметь доступ к данным, которое сохранило основное приложение. При помощи *AppGroup* можно получить доступ к общим `UserDefaults`, `Keychain`, расшаренным файлам.

Чтобы воспользоваться этим необходимо создать группу в разделе [App Groups](https://developer.apple.com/account/ios/identifier/applicationGroup) на сайте [developer.apple.com](https://developer.apple.com/). Идентификатор группы должен начинаться с `group.`, например - `group.com.touchin.Chat`. Затем в разделе [App IDs](https://developer.apple.com/account/ios/identifier/bundle) нужно каждому *App ID* в группе включить сервис *App Groups* и указать созданную группу.

Теперь можно создать provision profiles.

Для того чтобы шаринг начал работать нужно в настройках проекта на вкладке Capabilities включить App Groups. Для основного приложения удобно указать группу `group.$(CFBundleIdentifier)` (непосредственно редактируя `.entitlements` файл таргета).

Для того чтобы разделить группы экстеншена (на dev и enterprise) придется создать копию .entitlements файла и указать его в настройках проекта для конкретных конфигураций (вкладка Build Settings -> параметр Code Signing Entitlements).

Так, например, в проекте чата, были созданы два entitlements файла:

**ShareExtensionEnterprise.entitlements**

```xml
...
<key>com.apple.security.application-groups</key>
<array>
	<string>group.com.touchin.Chat</string>
</array>
...
```

**ShareExtensionStandard.entitlements**

```xml
...
<key>com.apple.security.application-groups</key>
<array>
	<string>group.com.touchin.Chat1</string>
</array>
...
```

которые были назначены соответствующим конфигурациям сборки.

Если нужно шарить Keychain то эту опцию также необходимо включить: *Capabilities -> Keychain Sharing.* У основного приложения и у расширений группа должна быть одна, например:

```xml
...
<key>keychain-access-groups</key>
<array>
	<string>$(AppIdentifierPrefix)chatKeychainGroup</string>
</array>
...
```

`$(AppIdentifierPrefix)` добавляется автоматически, его значение одинаково для основного приложения и для его расширений. Узнать префикс можно в разделе [App IDs](https://developer.apple.com/account/ios/identifier/bundle) на сайте [developer.apple.com](https://developer.apple.com/).

Определить группу в коде можно так:

```swift
#if ENTERPRISE
    private let appPrefix = "22995MMU00"
#else
    private let appPrefix = "22HA43V337"
#endif

    let keychainGroup = "\(appPrefix).chatKeychainGroup"
```

Флаг *ENTERPRISE* нужно добавить соответствующим конфигурациям в *Build Settings -> Other Swift Flags:* `-DENTERPRISE`

При сохранении / считывании значений из кейчейна нужно указать группу:

```swift
query[kSecAttrAccessGroup as String] = keychainGroup as CFString
```

## Files association

Можно сконфигурировать share extension таким образом, что при выборе для расшаривания файлов неподдерживаемых форматов - наш экстеншн в списке показан не будет. Эта настройка находится в info.plist файле созданного share extension:

```xml
<key>NSExtensionAttributes</key>
<dict>
	<key>NSExtensionActivationRule</key>
	<string>TRUEPREDICATE</string>
</dict>
```

По-умолчанию _TRUEPREDICATE_ означает что расширение поддерживает файлы любого формата. И не только файлы, ссылки, например, тоже. Можно изменить содержимое _NSExtensionActivationRule_ на:

```xml
<key>NSExtensionActivationRule</key>
<string>SUBQUERY (
      extensionItems,
      $extensionItem,
      SUBQUERY (
      $extensionItem.attachments,
      $attachment,
      (
      ANY $attachment.registeredTypeIdentifiers UTI-CONFORMS-TO "com.adobe.pdf"
      || ANY $attachment.registeredTypeIdentifiers UTI-CONFORMS-TO "public.jpeg"
      || ANY $attachment.registeredTypeIdentifiers UTI-CONFORMS-TO "com.microsoft.excel.xls"
      )
      ).@count > 0
      ).@count > 0
</string>
```

В примере соответственно указаны типы файлов _pdf_, _jpeg_ и _xls_.

UTI тип файла по расширению можно получить следующим образом:

```swift
import MobileCoreServices

let obtainUtiFileType = { fileExtension -> String? in
    if let unmanagedFileUTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,
								    fileExtension as CFString,
	                                                            nil) {

        let fileUTI = unmanagedFileUTI.takeRetainedValue() as CFString
        return fileUTI as String
    }

    return nil
}

```

## Share extension tips

По-умолчанию Xcode создает шаблон контроллера share extension, наследника от _SLComposeServiceViewController_, а также сториборд с этим контроллером. Скорее всего вам этот контроллер не понадобится, он плохо кастомизируется.

Создаем новый контроллер, указываем в сториборде его как _Initial View Controller_. Основная вью корневого контроллера расширения будет прозрачной (система делает ее прозрачной во время отображения, очевидно, для красоты). Также, корневой контроллер будет иметь заполненное свойство _extensionContext_

```swift
// Returns the extension context. Also acts as a convenience method for a view controller to check if it participating in an extension request.
@available(iOS 8.0, *)
open var extensionContext: NSExtensionContext? { get }
```

Оно пригодится для получения данных о расшариваемых файлах, а также для закрытия share extension.

Для адекватного отображения контроллера share extension на экране можно предложить следующую технику: _Initial Controller_ на сториборде сделать _UINavigationController_ с корневым _UIViewController_ (вью которого будет прозрачной), на который пушить контроллер, сверстанный в соответствии с дизайном.

Получение расшариваемых файлов происходит асинхронно. Рассмотрим на примере:

```swift
for case let content as NSExtensionItem in extensionContext?.inputItems ?? [] {
    for case let attachment as NSItemProvider in content.attachments ?? [] {
        let contentType = availableFileTypes.first { attachment.hasItemConformingToTypeIdentifier($0) }
        if let contentType = contentType {
            attachment.loadItem(forTypeIdentifier: contentType, options: nil) { data, error in
                if error == nil {
                    let fileUrl = data as! URL
                    // do with data what you want
                } else {
                    // an error occured
                }
            }
        }
    }
}
```

где `availableFileTypes` - список поддерживаемых типов в формате UTI.

ExtensionContext содержит массив расшариваемых файлов, объектов типа _NSExtensionItem_ (согласно доке - всегда). Проходим по нему. Затем, каждый файл может быть представлен по-разному. Это означает что приложение, которое расшаривает файл может отдать его в разных форматах. Например картинки - jpeg и png. Проверяем в цикле какой тип файла нам подходит и какой может отдать нам расширивающее приложение: `hasItemConformingToTypeIdentifier`. Затем, если нашелся поддерживаемый обеими сторонами формат - делаем асинхронный запрос на получение данных. В случае успеха - возвращается url файла.


Закрыть share extension существует два способа: отменить с ошибкой и успешно завершить. Визуально эти два способа выглядят по-разному: успешное завершение закрывает панель шаринга файлов.

```swift
switch type {
case .complete:
    extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
case .cancel:
    let error = NSError(domain: Bundle.main.bundleIdentifier ?? "", code: 0, userInfo: nil)
    extensionContext?.cancelRequest(withError: error)
}
```
