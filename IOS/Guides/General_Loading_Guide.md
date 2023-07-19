# Контроллер с обработкой ошибок и пустых состояний

- [Как добавить в проект](#Как-добавить-в-проект)
  - [Подключение cocoa pod](#Подключение-cocoa-pod)
- [Как использовать](#Как-использовать)
  - [Реализация ViewModel](#Реализация-viewmodel)
  - [Реализация LoadingController](#Рализация-loadingcontroller)
- [Как кастомизировать](#Как-кастомизировать)
  - [Стандартные плейсхолдеры и индикаторы загрузки](#Стандартные-плейсхолдеры-и-индикаторы-загрузки)
  - [Кастомизация плейсхолдеров](#Кастомизация-плейсхолдеров)

## Как добавить в проект
### Подключение cocoa pod
Для добавления в проект нужно подключить pod LeadKit версии 0.7.0 или выше и pod StatefulViewController:

```ruby
pod "LeadKit", '~> 0.7.0'
pod "StatefulViewController"
```

## Как использовать
Для того, чтобы получить работающий контроллер с обработкой ошибок, необходимо выполнить 2 шага:

- [Реализовать ViewModel](#Реализация-viewmodel)
- [Реализовать LoadingController](#Рализация-loadingcontroller)

### Реализация ViewModel
Для реализации ViewModel'и необходимо отнаследоваться от [GeneralDataLoadingViewModel](https://github.com/TouchInstinct/LeadKit/blob/master/Sources/Classes/DataLoading/GeneralDataLoading/GeneralDataLoadingViewModel.swift#L26) и передать шаблонным аргументом тип загружаемой модели. В дополнение к этому, можно переопределить конструктор и в нём вызвать родительский конструктор с аргументом типа `Single<T>`, где `T` ваш тип загружаемой модели.

Пример реализации:

```swift
final class ProfileViewModel: GeneralDataLoadingViewModel<UserProfile> {

    init(profileId: Int) {
        super.init(dataSource: PizzaNetworkService.shared.profile(for: profileId))
    }

}
```
Замечание: Тип загружаемой модели может быть любым, даже массивом `[T]`. Однако, если на экране присуствует пагинация, то следует использовать [PaginationWrapper](Pagination_Guide.md).

### Реализация LoadingController
Ваш контроллер должен имплементировать протокол [GeneralDataLoadingController](https://github.com/TouchInstinct/LeadKit/blob/master/Sources/Protocols/DataLoading/GeneralDataLoading/GeneralDataLoadingController.swift#L23). Также рекомендуется имплементирвать `StatefulViewController` и [DisposeBagHolder](https://github.com/TouchInstinct/LeadKit/blob/master/Sources/Protocols/Rx/DisposeBagHolder.swift#L26) для получения стандартной реализации многих методов из [GeneralDataLoadingController](https://github.com/TouchInstinct/LeadKit/blob/master/Sources/Protocols/DataLoading/GeneralDataLoading/GeneralDataLoadingController.swift#L23) через расширение.

Внутри контроллера в методе `viewDidLoad()` необходимо вызвать `initialLoadDataLoadingView()`.

Пример реализации:

```swift
final class ProfileViewController: UIViewController,
    StatefulViewController,
    DisposeBagHolder {

    var viewModel: ProfileViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        initialLoadDataLoadingView()
    }

}

extension ProfileViewController: GeneralDataLoadingController {

    func onLoadingState() {
        startLoading()
    }

    func onResultsState(result: UserProfile) {
        endLoading()
        reloadTable(with: result)
    }

    func onEmptyState() {
        endLoading()
    }

    func onErrorState(error: Error) {
        endLoading(error: error)
    }

}
```

## Как кастомизировать

### Стандартные плейсхолдеры и индикаторы загрузки
По умолчанию, большинство методов [GeneralDataLoadingController](https://github.com/TouchInstinct/LeadKit/blob/master/Sources/Protocols/DataLoading/GeneralDataLoading/GeneralDataLoadingController.swift#L23) уже имеют [стандартную реализацию](https://github.com/TouchInstinct/LeadKit/blob/master/Sources/Extensions/DataLoading/GeneralDataLoading/GeneralDataLoadingController%2BDefaultImplementation.swift#L26) для всех возможных UI-состояний. Но, при необходимости, их можно переопределить.

### Кастомизация плейсхолдеров
Плейсхолдеры храняться в свойствах контроллера:

- `loadingView` - плейсхолдер, который будет показан при загрузке данных.
- `errorView` - плейсхолдер, который будет показан при ошибке загрузки данных.
- `emptyView` - плейсхолдер, который будет показан при пустых результатах загрузки.

Им необходимо задать соотвествующие значения в методе `setupStateViews()`.

Пример реализации:

```swift
extension ProfileViewController: GeneralDataLoadingController {

    // ...

    func setupStateViews() {
        loadingView = TextPlaceholderView(title: .loading)
        errorView = TextWithButtonPlaceholder(title: .error,
                                              buttonTitle: .retryLoadMore,
                                              tapHandler: reload)
        emptyView = TextPlaceholderView(title: .empty)
    }

}
```