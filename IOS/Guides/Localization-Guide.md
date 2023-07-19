# Система Локализации
В iOS проектах используется следующая система локализации:

Все строки, которые используются в проекте заносятся в json-файл, находящийся в отдельном репозитории.

К каждому iOS проекту должен быть подключен сабмодуль [build-scripts](https://github.com/TouchInstinct/BuildScripts), содержащий [скрипт](https://github.com/TouchInstinct/BuildScripts/blob/master/xcode/build_phases/localization.sh), который [подключается](BuildScripts/Build_Scripts_Guide.md) как билд фаза и преобразует данный json в файлы локализации в проекте.

Также необходимо создать или использовать из [LeadKit](https://github.com/TouchInstinct/LeadKit) extension для String:

```swift
import Foundation

extension String {

    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

}
```

В проекте также создается отдельный файл с extension для String с наименованием `String+Localization.swift`. Он должен находиться в папке **Resourses**. В данном файле хранятся локализованные строки формата:

```swift
import Foundation

extension String {
	static let commonGlobalAppName = "common_global_app_name".localized()
	static let iosSearchTicketsCitiesHint = "ios_search_tickets_cities_hint".localized()
}
```

Внутри проекта, локализация осуществляется путем вызова:

```swift
searchTextField.placeholder = .iosSearchTicketsCitiesHint
```
