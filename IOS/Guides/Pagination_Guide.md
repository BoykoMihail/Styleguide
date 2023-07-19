# Пагинация в UITableView и UICollectionView

- [Как добавить в проект](#Как-добавить-в-проект)
  - [Подключение cocoa pod](#Подключение-cocoa-pod)
- [Как использовать](#Как-использовать)
  - [Реализация курсора](#Реализация-курсора)
  - [Оборачивание UITableView в PaginationTableViewWrapper](#Оборачивание-uitableview-в-paginationtableviewwrapper)
  - [Реализация методов делегата PaginationTableViewWrapperDelegate](#Реализация-методов-делегата-paginationtableviewwrapperdelegate)
  
- [Как кастомизировать](#Как-кастомизировать)
  - [Стандартные плейсхолдеры и индикаторы загрузки](#Стандартные-плейсхолдеры-и-индикаторы-загрузки)
  - [Кастомизация пустых плейсхолдеров](#Кастомизация-пустых-плейсхолдеров)
  - [Кастомизация плейсхолдеров для ошибок](#Кастомизация-плейсхолдеров-для-ошибок)
  - [Кастомная обработка ошибок](#Кастомная-обработка-ошибок)
  - [Кастомизация индикатора загрузки](#Кастомизация-индикатора-загрузки)
  - [Кастомизация индикатора подгрузки](#Кастомизация-индикатора-подгрузки)
  - [Кастомизация кнопки повтора подгрузки](#Кастомизация-кнопки-повтора-подгрузки)
  - [Следование плейсхолдера за скроллом таблицы](#Следование-плейсхолдера-за-скроллом-таблицы)
- [Если пагинация не нужна](#Если-пагинация-не-нужна)


## Как добавить в проект
### Подключение cocoa pod
Для добавления в проект нужно подключить pod LeadKit версии 0.7.0 или выше:

```ruby
pod "LeadKit", '~> 0.7.0'
```

## Как использовать
Для того, чтобы получить работающую таблицу с пагинацией необходимо выполнить четыре шага:

- [Реализовать курсор](#реализация-курсора)
- [Создать курсор](#создание-курсора)
- [Обернуть UI(Table/Collection)View в PaginationWrapperDelegate](#оборачивание-uitableview)
- [Реализовать методы делегата PaginationWrapperDelegate](#реализация-методов-делегата-paginationwrapperdelegate)

### Реализация курсора
За основу лучше всего брать [TotalCountCursor](https://github.com/TouchInstinct/LeadKit/blob/master/Sources/Classes/DataLoading/Cursors/TotalCountCursor.swift#L26) и настраивать его через [TotalCountCursorConfiguration](https://github.com/TouchInstinct/LeadKit/blob/master/Sources/Protocols/DataLoading/PaginationDataLoading/TotalCountCursorConfiguration.swift#L27).

Пример реализации:

```swift
final class PizzaListingCursorConfiguration: TotalCountCursorConfiguration {

    typealias ResultType = PaginatedResponse<Pizza>

    private var page: Int = 1
    private let pizzaType: PizzaType

    init(pizzaType: PizzaType) {
        self.pizzaType = pizzaType
    }

    init(resetFrom other: PizzaListingCursorConfiguration) {
        self.pizzaType = other.pizzaType
    }

    func resultSingle() -> Single<ResultType> {
        return PizzaNetworkService.shared
            .pizzaListing(pizzaType: pizzaType, page: page)
            .do(onSuccess: { [weak self] _ in
                self?.page += 1
            })
    }

}

typealias PizzaListingCursor = TotalCountCursor<PizzaListingCursorConfiguration>

extension TotalCountCursor where CursorConfiguration == PizzaListingCursorConfiguration {

    convenience init(pizzaType: PizzaType) {
        self.init(configuration: PizzaListingCursorConfiguration(pizzaType: pizzaType))
    }

}
```

Замечание: ваш `ResultType` должен имплементировать [TotalCountCursorListingResult](https://github.com/TouchInstinct/LeadKit/blob/master/Sources/Protocols/DataLoading/PaginationDataLoading/TotalCountCursorListingResult.swift#L25). Также можно воспользоваться стандартной реализацией [DefaultTotalCountCursorListingResult](https://github.com/TouchInstinct/LeadKit/blob/cd00fb2f2fde46472ac09d315d182837b25950da/Sources/Structures/DataLoading/Cursors/DefaultTotalCountCursorListingResult.swift#L24).

### Создание курсора

```swift
final class PizzaListViewModel: BaseViewModel {

    let cursor: PizzaListingCursor

    init(pizzaType: PizzaType) {
        self.cursor = PizzaListingCursor(pizzaType: pizzaType)
    }

}
```

### Оборачивание в PaginationWrapper
Далее мы оборачиваем UITableView или UICollectionView в [PaginationWrapperDelegate](https://github.com/TouchInstinct/LeadKit/blob/master/Sources/Classes/DataLoading/PaginationDataLoading/PaginationWrapper.swift#L28)

Пример реализации:

```swift
final class PizzaListViewController: UIViewController {

    var viewModel: PizzaListViewModel!

    @IBOutlet private weak var tableView: UITableView!

    private lazy var paginationWrapper = {
        PaginationWrapper(wrappedView: AnyPaginationWrappable(view: tableView),
                          cursor: viewModel.cursor,
                          delegate: self)
    }()

    // ...

}

```


### Реализация методов делегата PaginationWrapperDelegate
Далее мы реализуем обязательные методы делегата [PaginationWrapperDelegate](https://github.com/TouchInstinct/LeadKit/blob/master/Sources/Structures/DataLoading/PaginationDataLoading/PaginationWrapperDelegate.swift#L25)

Пример реализации:

```swift
extension PizzaListViewController: PaginationWrapperDelegate {

    typealias DataSourceType = PizzaListingCursor

    func paginationWrapper(didLoad newItems: [Pizza],
                           using dataSource: PizzaListingCursor) {

        <#add items to table or collection#>
    }

    func paginationWrapper(didReload allItems: [Pizza],
                           using dataSource: PizzaListingCursor) {

        <#replace all items with given items in table or collection#>
    }

    func clearView() {
        <#remove all items from table or collection#>
    }

}
```

## Как кастомизировать

### Стандартные плейсхолдеры и индикаторы загрузки
По умолчанию, большинство методов [PaginationWrapperDelegate](https://github.com/TouchInstinct/LeadKit/blob/master/Sources/Structures/DataLoading/PaginationDataLoading/PaginationWrapperDelegate.swift#L25) уже имеют [стандартную реализацию](https://github.com/TouchInstinct/LeadKit/blob/master/Sources/Extensions/DataLoading/PaginationDataLoading/PaginationWrapperDelegate%2BDefaultImplementation.swift#L25) для всех возможных UI-состояний UITableView или UICollectionView. Но, при необходимости, их можно переопределить.

### Кастомизация пустых плейсхолдеров
Для того, чтобы в UITableView или UICollectionView показывался кастомный placeholder при получении пустого списка результатов мы должны реализовать метод делегата [emptyPlaceholder()](https://github.com/TouchInstinct/LeadKit/blob/master/Sources/Structures/DataLoading/PaginationDataLoading/PaginationWrapperDelegate.swift#L48).

Этот метод будет вызван у объекта реализующего [PaginationWrapperDelegate](https://github.com/TouchInstinct/LeadKit/blob/master/Sources/Structures/DataLoading/PaginationDataLoading/PaginationWrapperDelegate.swift#L25) после получения пустого результата при следующих ситуациях:

- После первого запроса.
- После полной перезагрузки данных (Pull-to-refresh).

Пример реализации:

```swift
extension NotificationsViewController: PaginationWrapperDelegate {

    // ...

    func emptyPlaceholder() -> UIView {
        return UIView.loadFromNib(named: "EmptyContentPlaceholder")
    }

}
```

### Кастомизация плейсхолдеров для ошибок
Иногда необходимо показывать разные placeholder'ы для разных ошибок, которые могут приходить от сервера или случаться из-за сбоев в сети.
Для того, чтобы в таблице показывался кастомный placeholder при получении ошибки мы должны реализовать метод делегата [errorPlaceholder(forError:)](https://github.com/TouchInstinct/LeadKit/blob/master/Sources/Structures/DataLoading/PaginationDataLoading/PaginationWrapperDelegate.swift#L63).

Этот метод будет вызван у объекта реализующего [PaginationWrapperDelegate](https://github.com/TouchInstinct/LeadKit/blob/master/Sources/Structures/DataLoading/PaginationDataLoading/PaginationWrapperDelegate.swift#L25) после получения ошибки в следующих ситуациях:

- После первого запроса.
- После полной перезагрузки данных (Pull-to-refresh).

Этот метод НЕ БУДЕТ вызван после получения ошибки в следующих случаях:

- После попытки загрузить следющую часть данных.

Пример реализации:

```swift
extension NotificationsViewController: PaginationWrapperDelegate {

    // ...

    func errorPlaceholder(forError error: Error) -> UIView {
        if error is ApiError {
            return ApiErrorPlaceholder.loadFromNib() as ApiErrorPlaceholder
        } else {
            return UnknownErrorPlaceholder.loadFromNib(named: "UnknownErrorPlaceholder")
        }
    }

}
```

### Кастомная обработка ошибок
В редких случаях, необходимо как-то особенно обработать ошибку от сервера. Для этого мы должны реализовать метод делегата [customInitialLoadingErrorHandling(forError:)](https://github.com/TouchInstinct/LeadKit/blob/master/Sources/Structures/DataLoading/PaginationDataLoading/PaginationWrapperDelegate.swift#L56). В этом методе необходимо вернуть `true`, если мы обработали ошибку самостоятельно, тогда плейсхолдер не будет показан.

Этот метод будет вызван у объекта реализующего [PaginationWrapperDelegate](https://github.com/TouchInstinct/LeadKit/blob/master/Sources/Structures/DataLoading/PaginationDataLoading/PaginationWrapperDelegate.swift#L25) после получения ошибки в следующих ситуациях:

- После первого запроса.
- После полной перезагрузки данных (Pull-to-refresh).

Этот метод НЕ БУДЕТ вызван после получения ошибки в следующих случаях:

- После попытки загрузить следющую часть данных.

Пример реализации:

```swift
extension NotificationsViewController: PaginationWrapperDelegate {

    // ...

    func customInitialLoadingErrorHandling(forError error: Error) -> Bool {
        if error is ApiError {
            UIAlertController.showApiErrorAlert(for: self)
            return true
        } else {
            return false
        }
    }

}
```


### Кастомизация индикатора загрузки
Индикатор загрузки показывается по центру UITableView или UICollectionView сразу после начальной загрузки данных.

Для того, чтобы в таблице показывался кастомный индикатор загрузки мы должны реализовать метод делегата [initialLoadingIndicator()](https://github.com/TouchInstinct/LeadKit/blob/master/Sources/Structures/DataLoading/PaginationDataLoading/PaginationWrapperDelegate.swift#L69).

Пример реализации:

```swift
extension NotificationsViewController: PaginationWrapperDelegate {

    // ...

    func initialLoadingIndicator() -> AnyLoadingIndicator {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)

        return AnyLoadingIndicator(activityIndicator)
    }

}
```

### Кастомизация индикатора подгрузки
Индикатор подгрузки показывается снизу UITableView или UICollectionView после начала подгрузки следующей части данных.

Для того, чтобы в таблице показывался кастомный индикатор подгрузки мы должны реализовать метод делегата [loadingMoreIndicator()](https://github.com/TouchInstinct/LeadKit/blob/master/Sources/Structures/DataLoading/PaginationDataLoading/PaginationWrapperDelegate.swift#L74).

Пример реализации:

```swift
extension NotificationsViewController: PaginationWrapperDelegate {

    // ...

    func loadingMoreIndicator() -> AnyLoadingIndicator {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)

        return AnyLoadingIndicator(activityIndicator)
    }

}
```

### Кастомизация кнопки повтора подгрузки
Кнопка подгрузки показывается снизу UITableView или UICollectionView в случае получения ошибки после попытки подгрузки следующей части данных.

Для того, чтобы в таблице показывалась кастомная кнопка повтора погрузки мы должны реализовать метод делегата [footerRetryButton()](https://github.com/TouchInstinct/LeadKit/blob/master/Sources/Structures/DataLoading/PaginationDataLoading/PaginationWrapperDelegate.swift#L79).

Дополнительно, можно реализовать метод для определения высоты кнопки [footerRetryButtonHeight()](https://github.com/TouchInstinct/LeadKit/blob/master/Sources/Structures/DataLoading/PaginationDataLoading/PaginationWrapperDelegate.swift#L84).

Пример реализации:

```swift
extension NotificationsViewController: PaginationWrapperDelegate {

    // ...

    func footerRetryButton() -> UIButton {
        return RetryLoadMoreButton()
    }
    
    func footerRetryButtonHeight() -> CGFloat {
        return 64
    }

}
```

### Следование плейсхолдера за скроллом таблицы
Чтобы плейсхолдер следовал за скроллом таблицы необходимо подписать PaginationTableViewWrapper на Observable который будет посылать события с типом CGPoint (content offset).

Пример реализации:

```swift
final class PizzaListViewController: UIViewController {

    private lazy var paginationWrapper: PaginationWrapperType = {
        let wrapper = PaginationWrapper(wrappedView: AnyPaginationWrappable(view: tableView),
                                        cursor: viewModel.cursor,
                                        delegate: self)
        wrapper.setScrollObservable(tableView.rx.contentOffset.asObservable())
        return wrapper
    }()

}
```

## Если пагинация не нужна
Если нужна только обработка ошибок и пустых результатов запроса, то можно воспользоваться [SingleLoadCursorConfiguration](https://github.com/TouchInstinct/LeadKit/blob/master/Sources/Classes/DataLoading/Cursors/SingleLoadCursor.swift#L26) в который нужно просто передать объект `Single`.

Пример:

```swift
typealias SinglePizzaListingCursor = TotalCountCursor<SingleLoadCursorConfiguration<[Pizza]>>

extension TotalCountCursor where CursorConfiguration == SingleLoadCursorConfiguration<[Pizza]> {

    convenience init() {
        let listingSingle = PizzaNetworkService.shared.pizzaListing()
        self.init(configuration: SingleLoadCursorConfiguration(loadingSingle: listingSingle)
    }

}

let cursor = SinglePizzaListingCursor()
```