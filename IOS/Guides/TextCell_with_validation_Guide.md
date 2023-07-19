# Ячейка с текстовым полем и валидацией

- [Как добавить в проект](#Как-добавить-в-проект)
  - [Подключение cocoa pod](#Подключение-cocoa-pod)
- [Как использовать](#Как-использовать)
  - [Реализация ViewModel ячейки](#Реализация-viewmodel-ячейки)
  - [Реализация ячейки](#Реализация-ячейки)
  - [Реализация ViewModel для контроллера](#Реализация-viewmodel-для-контроллера)
    - [Этапы настройки текстового поля во ViewModel'и контроллера](#Этапы-настройки-текстового-поля-во-viewmodelи-контроллера)
  - [Реализация контроллера](#Реализация-контроллера)

## Как добавить в проект
### Подключение cocoa pod
Для добавления в проект нужно подключить pod LeadKit версии 0.7.0 или выше и pod LeadKitAdditions 0.2.0:

```ruby
pod "LeadKit", '~> 0.7.0'
pod "LeadKitAdditions", '~> 0.2.0'
```

## Как использовать
Для того, чтобы получить работающий контроллер с обработкой ошибок, необходимо выполнить 4 шага:

- [Реализовать ViewModel ячейки](#Реализация-viewmodel-ячейки)
- [Реализовать ячейку](#Реализация-ячейки)
- [Реализовать ViewModel для контроллера](#Реализация-viewmodel-для-контроллера)
- [Реализовать контроллер](#Реализация-контроллера)

### Реализация ViewModel ячейки
Для реализации ViewModel'и необходимо отнаследоваться от [TextFieldViewModel](https://github.com/TouchInstinct/LeadKit/blob/master/Sources/Classes/Views/TextField/TextFieldViewModel.swift#L27) и передать шаблонными аргументами два типа, которые реализуют работу с событиями View и ViewModel. 

Пример реализации:

```swift
final class MyTextCellViewModel: TextFieldViewModel<BaseTextFieldViewEvents, BaseTextFieldViewModelEvents> {

	// здесь могут быть дополнительные поля для настройки внешнего вида ячейки
	
}
```

В примере:

- [BaseTextFieldViewEvents](https://github.com/TouchInstinct/LeadKitAdditions/blob/master/Sources/Classes/BaseTextFieldViewModel/BaseTextFieldViewModel.swift#L29) - базовая реализация событий исходящих из View. Основное свойство тут `textChangedDriver`. При изменении текста в поле ввода, `textChangedDriver` посылает событие с типом `String?`. Этот класс можно отнаследовать, чтобы добавить свои события (например, потеря фокуса или тап по крестику)
 
- [BaseTextFieldViewModelEvents](https://github.com/TouchInstinct/LeadKitAdditions/blob/master/Sources/Classes/BaseTextFieldViewModel/BaseTextFieldViewModel.swift#L43) - базовая реализация событий исходящих из ViewModel, которые влияют на View. Основное свойство тут `setTextDriver`. Он посылает событие с типом `String?` чтобы изменить текст в поле ввода. Также здесь присутвуют `changeValidationStateDriver` (для обновления состояния оффлайн валидации) и `changeOnlineValidationStateDriver` (для обновления состояния онлайн валидации).

### Реализация ячейки
Ячейке не требуется наследоваться от каких-либо специальных классов или реализовывать какие-либо протоколы.

Тем не менее, обязательно необходимо:

- В `prepareForReuse()` вызывать метод `unbindView()` у ViewModel'и ячейки.
- В методе конфигурации (`configure(with:)` для TableKit):
  -  создать модель `BaseTextFieldViewEvents` и передать её в метод `bind(viewEvents:)` ViewModel'и ячейки.
  - Забиндить текстовое поле к событиям `setTextDriver` в `viewModelEvents`.

Пример реализации:

```swift
final class TextCell: SeparatorCell, ConfigurableCell {

    private let textField = UITextField()

    private var viewModel: MyTextCellViewModel?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(textField)
        textField.setToCenter()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        viewModel?.unbindView()
    }

    func configure(with viewModel: MyTextCellViewModel) {
        self.viewModel = viewModel

        // Биндинг текстовой ячейки к модели данных
        let viewEvents = BaseTextFieldViewEvents(textField: textField)

        viewModel.bind(viewEvents: viewEvents)

       // Биндинг модели данных к текстовому полю
        viewModel.viewModelEvents
            .setTextDriver
            .drive(textField.rx.text)
            .disposed(by: viewModel.disposeBag)
       
        // Биндинг стейта валидации к ячейке
        viewModel.viewModelEvents
            .changeValidationStateDriver
            .drive(validationStateChanged)
            .disposed(by: viewModel.disposeBag)
    }

    private var validationStateChanged: Binder<ValidationItemState> {
        return Binder(self) { base, value in
            switch value {
            case .initial, .valid:
                base.textField.textColor = .black
                base.configureSeparator(with: .bottom(SeparatorConfiguration(color: .lightGray)))
            case .correction, .error:
                base.textField.textColor = .red
                base.configureSeparator(with: .bottom(SeparatorConfiguration(color: .red)))
            }
        }
    }

    static let defaultHeight: CGFloat? = 44

}
```

### Реализация ViewModel для контроллера
ViewModel'и контроллера также не нужно наследовать или реализовывать какие-либо специальные классы или протоколы.

Типичная ViewModel может содержать поля со следующими типами:

- `ValidationService` - сервис для регистрации и валидации полей.
- `Variable<T>` - состояние модели данных. Где `T` - тип модели данных.
- `DisposeBag` - для подписки на изменения текста в поле ввода или для других биндингов.

#### Этапы настройки текстового поля во ViewModel'и контроллера
1. Создание биндинга к конкретному полю в модели данных.
2. Создание модели событий ViewModel'и для поля в модели данных.
3. Создание ViewModel'и ячейки.
4. Биндинг к UI событиям ячейки.

Пример реализации:

```swift
final class LoginViewModel: BaseViewModel {

    private let validationService = ValidationService()

    private let loginUserVariable = Variable<LoginSpreeUser>(.new)

    let disposeBag = DisposeBag()

    lazy var cellViewModels = {
        [emailCellViewModel, passwordCellViewModel]
    }()

    init() {
    }

    func validate() {
        _ = validationService.validate()
    }

    private var emailCellViewModel: MyTextCellViewModel {
        return cellViewModel(getFieldClosure: { $0.email },
                             mergeFieldClosure: { $0.copyWith(email: $1) },
                             rules: [RequiredRule(), EmailRule()])
    }

    private var passwordCellViewModel: MyTextCellViewModel {
        return cellViewModel(getFieldClosure: { $0.password },
                             mergeFieldClosure: { $0.copyWith(password: $1) })
    }

    private func cellViewModel(getFieldClosure: @escaping DataModelFieldBinding<LoginSpreeUser>.GetFieldClosure,
                               mergeFieldClosure: @escaping DataModelFieldBinding<LoginSpreeUser>.MergeFieldClosure,
                               rules: [Rule] = [RequiredRule()]) -> MyTextCellViewModel {
                               
        // 1. Создание биндинга к конкретному полю в модели данных.
        let binding = loginUserVariable.fieldBinding(getFieldClosure: getFieldClosure,
                                                     mergeFieldClosure: mergeFieldClosure)

        // 2. Создание модели событий ViewModel'и для поля в модели данных.
        let fieldViewModelEvents = BaseTextFieldViewModelEvents(binding: binding,
                                                                rules: rules,
                                                                validationService: validationService)
        // 3. Создание ViewModel'и ячейки.
        let viewModel = MyTextCellViewModel(viewModelEvents: fieldViewModelEvents)

        // 4. Биндинг к UI событиям ячейки.
        viewModel.mapViewEvents {
            // Тут изменения текста в поле ввода передаются в модель данных напрямую
            binding.mergeStringToModel(from: $0.textChangedDriver)
        }
        .disposed(by: disposeBag)

        return viewModel
    }

}
```

Структура модели данных в примере:

```swift
struct LoginSpreeUser: ImmutableMappable {

    let email: String
    let password: String

}

extension LoginSpreeUser {

    static let new = LoginSpreeUser(email: "", password: "")

    func copyWith(email: String? = nil,
                  password: String? = nil) -> LoginSpreeUser {

        return LoginSpreeUser(email: email ?? self.email,
                              password: password ?? self.password)
    }

}
```

### Реализация контроллера
В контроллере ничего особенного делать не нужно. Далее приведён код исключительно в целях наглядности.

Пример реализации:

```swift
final class LoginViewController: UIViewController, ConfigurableController {

    var viewModel: LoginViewModel!

    private let tableView = UITableView(frame: .zero, style: .plain)
    private let validateButton = UIButton(type: .system)

    private lazy var tableDirector = {
        TableDirector(tableView: tableView)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initialLoadView()
    }

    func addViews() {
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        validateButton.setTitle("Validate", for: .normal)

        view.addSubview(tableView)
        view.addSubview(validateButton)

        tableView.setToCenter()
        validateButton.setToCenter(withSize: CGSize(width: 128, height: 32))

        let rows = viewModel.cellViewModels.map { TableRow<TextCell>(item: $0) }

        tableDirector.replace(withRows: rows)
    }

    func bindViews() {
        validateButton.rx
            .controlEvent(.touchUpInside)
            .asDriver()
            .drive(validateDidTapped)
            .disposed(by: viewModel.disposeBag)
    }

    var validateDidTapped: Binder<Void> {
        return Binder(self) { base, _ in
            base.viewModel.validate()
        }
    }

}
```