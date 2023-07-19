Краткий гайд по настройке фреймворка [Chatto](https://github.com/badoo/Chatto). Версия пода на момент написания - **3.0.1**

Гайд представляет собой максимально краткий и быстрый способ подключения Chatto в проект - простая ячейка с текстом. ChattoAdditions рассмотрены не будут.

- [Dive into Chatto](#dive-into-chatto)
	- [BaseChatViewController](#basechatviewcontroller)
	- [ChatItemProtocol](#chatitemprotocol)
	- [ChatDataSourceProtocol](#chatdatasourceprotocol)
	- [ChatItemPresenterBuilderProtocol](#chatitempresenterbuilderprotocol)
	- [ChatItemPresenterProtocol](#chatitempresenterprotocol)
- [Put things together](#put-things-together)


# Dive into Chatto

Рассмотрим базовые сущности фреймворка, использование которых необходимо для начала работы с ним:

- BaseChatViewController
- ChatItemProtocol
- ChatDataSourceProtocol
- ChatItemPresenterBuilderProtocol
- ChatItemPresenterProtocol

## BaseChatViewController

Основной объект инфраструктуры чата. Обращается к датасету `ChatDataSourceProtocol` за данными для отрисовки в ячейках. Содержит информацию о `ChatItemPresenterBuilderProtocol` для привязки ячеек к моделям данных и их конфигурирования. Контроллер сам отслеживает состояние клавиатуры: ловит фокус ввода у `ChatInputView`, конфигурирует insets у UICollectionView и позволяет скрывать клавиатуру любым способом (свайп вниз или тап).

Для того чтобы контроллер работал необходимо:

- указать объект датасета, свойство `chatDataSource`
- перегрузить метод, связывающий типы элементов данных с конкретными ячейками:

```swift
func createPresenterBuilders() -> [ChatItemType: [ChatItemPresenterBuilderProtocol]]
```
- перегрузить метод, в котором создается панель для ввода (например, для ввода текста сообщения понадобится вью с *UITextField* на борту):

```swift
func createChatInputView() -> UIView
```

## ChatItemProtocol

Протокол, которому должны следовать модели данных для отображения в Chatto. Используется в контроллере для связки моделей данных и ячеек для их отображения. Используется в датасете: модели данных хранятся там в виде `[ChatItemProtocol]`. По сути, модель следующая этому протоколу, должна содержать как минимум два поля:

```swift
var uid: String { get }
var type: ChatItemType { get }
```

## ChatDataSourceProtocol

Протокол, описывающий datasource для Chatto.

Флаги доступности сообщений *ниже* и *выше* загруженного блока данных. 

```swift
var hasMoreNext: Bool { get }
var hasMorePrevious: Bool { get }
```

При скролле UICollectionView контроллер чата отслеживает приближение к верхней или нижней границе контента и, если соответствующий флаг установлен, вызовет один из методов подгрузки данных:

```swift
func loadNext()
func loadPrevious()
```

Загруженные модели следует сохранять в 

```swift
var chatItems: [ChatItemProtocol] { get }
```
Именно из этого массива берутся данные для отображения.

Кроме того, есть еще свойство делегата, явно его устанавливать не нужно - это происходит автоматически при назначении датасорса контроллеру.

```swift
weak var delegate: ChatDataSourceDelegateProtocol? { get set }
```

Есть еще метод для ограничения размера локального кеша данных, но в простейшем случае можно сделать так:

```swift
func adjustNumberOfMessages(preferredMaxCount: Int?, focusPosition: Double, completion:((didAdjust: Bool)) -> Void) {
	completion(true)
}
```

## ChatItemPresenterBuilderProtocol

Обекты, следующие этому протоколу вызываются контроллером для создания объектов `ChatItemPresenterProtocol`, соответствующих конкретной модели данных `ChatItemProtocol`. Другими словами, протокол служит для связки разных моделей данных с разными ячейками для их отображения.

```swift
func canHandleChatItem(_ chatItem: ChatItemProtocol) -> Bool
func createPresenterWithChatItem(_ chatItem: ChatItemProtocol) -> ChatItemPresenterProtocol
var presenterType: ChatItemPresenterProtocol.Type { get }
```

## ChatItemPresenterProtocol

Объекты, следующие этому протоколу, отвечают за настройку ячейки: регистрация ячейки в UICollectionView, заполнение ячейки данными, установка высоты, обработка событий показа и скрытия ячейки. Ниже приведены обязательные для реализации методы:

```swift
static func registerCells(_ collectionView: UICollectionView)
func heightForCell(maximumWidth width: CGFloat, decorationAttributes: ChatItemDecorationAttributesProtocol?) -> CGFloat
func dequeueCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
func configureCell(_ cell: UICollectionViewCell, decorationAttributes: ChatItemDecorationAttributesProtocol?)
```

# Put things together

Создадим viewmodel для чата:

```swift
struct TextMessageItem: ChatItemProtocol {

    // MARK: - ChatItemProtocol
    let type: ChatItemType = "TextMessage"
    let uid: String

    // MARK: - Data
    let textMessage: String
    let textHeight: CGFloat

}
```

Создадим ячейку для отображения этой модели:

```swift
class TextMessageCell: UICollectionViewCell {
	static let reuseCellIdentifier = "textMessageCell"
	
	private lazy var messageTextView: UITextView = {
        let textView = UITextView(frame: self.bounds)
        textView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(textView)
        return textView
    }()
    
    func configure(with textMessageItem: TextMessageItem) {
        messageTextView.text = textMessageItem.text
    }
}
```

Необходимо создать датасет, объект следующий протоколу `ChatDataSourceProtocol`. Рассмотрим пример реализации:

```swift
class ChatDataSource: ChatDataSourceProtocol {

    let hasMoreNext     = false
    let hasMorePrevious = false
    var chatItems: [ChatItemProtocol] = []
    weak var delegate: ChatDataSourceDelegateProtocol?

    private let chatId: String

    // MARK: - Init

    init(chatId: String) {
        self.chatId = chatId
    }

    // MARK: - Public methods

    func initialLoad() {
        load { [weak self] (items) in
            guard let strongSelf = self else {
                return
            }

            strongSelf.chatItems = items

            DispatchQueue.main.async {
                strongSelf.delegate?.chatDataSourceDidUpdate(strongSelf, updateType: .firstLoad)
            }
        }
    }

    func loadNext() {}

    func loadPrevious() {}

    func adjustNumberOfMessages(preferredMaxCount: Int?, focusPosition: Double, completion: ((didAdjust: Bool)) -> Void) {
        completion(true)
    }

    // MARK: - Private stuff

    private func load(complete: @escaping ([ChatItemProtocol]) -> Void) {
    	// load messages from server with chatId and call completion
    }

}
```

Создадим презентер для ячейки и презентер-билдер для вью модели:

```swift
class TextMessagePresenterBuilder: ChatItemPresenterBuilderProtocol {

    public func canHandleChatItem(_ chatItem: ChatItemProtocol) -> Bool {
        return chatItem is TextMessageItem
    }

    public func createPresenterWithChatItem(_ chatItem: ChatItemProtocol) -> ChatItemPresenterProtocol {
        assert(canHandleChatItem(chatItem))
        return TextMessagePresenter(textMessageItem: (chatItem as? TextMessageItem)!)
    }

    public var presenterType: ChatItemPresenterProtocol.Type {
        return TextMessagePresenter.self
    }

}

class TextMessagePresenter: ChatItemPresenterProtocol {

    let textMessageItem: TextMessageItem

    init(textMessageItem: TextMessageItem) {
        self.textMessageItem = textMessageItem
    }

    static func registerCells(_ collectionView: UICollectionView) {
        collectionView.register(TextMessageCell.self, forCellWithReuseIdentifier: TextMessageCell.reuseCellIdentifier)
    }

    func dequeueCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: TextMessageCell.reuseCellIdentifier, for: indexPath)
    }

    func configureCell(_ cell: UICollectionViewCell, decorationAttributes: ChatItemDecorationAttributesProtocol?) {
    	(cell as? TextMessageCell)?.configure(with: textMessageItem)
    }

    func heightForCell(maximumWidth width: CGFloat, decorationAttributes: ChatItemDecorationAttributesProtocol?) -> CGFloat {
        return textMessageItem.textHeight
    }

}
```

Код контроллера теперь можно дополнить следующим образом:

```swift
override func viewDidLoad() {
	super.viewDidLoad()
   ...
   let dataSource = ChatDataSource(chatId: <#some chat ID#>)
   chatDataSource = dataSource
   chatDataSourceDidUpdate(dataSource)
   dataSource.initialLoad()
}

...

override func createPresenterBuilders() -> [ChatItemType: [ChatItemPresenterBuilderProtocol]] {
    return [TextMessageItem.chatItemType: [TextMessagePresenterBuilder()]]
}
```

___

На этом всё, минимальная версия Chatto сконфигурирована и готова к работе. За дополнительной информацией можно обратиться к [вики Chatto](https://github.com/badoo/Chatto/wiki).
