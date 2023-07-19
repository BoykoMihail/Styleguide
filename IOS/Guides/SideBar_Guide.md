# Настрой и используй Sidebar в проектах

Для создания Sidebar в приложении необходимо установить зависимость [SideMenu](https://github.com/jonkykong/SideMenu). Для этого необходимо добавить `pod 'SideMenu'` в Podfile и установить зависимости. На момент написания гайда актуальной версией является версия **2.3.3**

Концепция работы библиотеки - существует статическая сущность `SideMenuManager` в памяти, которая держит в себе ссылки на левый и правый контроллер меню. Данные контроллеры меню представляют из себя сущности типа `UISideMenuNavigationController`. Работа с ними осуществляется так же легко, как и с обычными контроллерами навигации. Чтобы механизм вызова меню существовал в определенном контроллере, необходимо добавить распознаватели жестов на вид контроллера

## Процесс построения меню

- **Проинициализировать**. Создать контроллер меню. Обернуть его в `UISideMenuNavigationController`.  Указать сторону для этого контроллера (по умолчанию правая). Обновить ссылки статической сущности.

- **Сконфигурировать**. Настроить меню по типу показа, по ширине. Выставить свойства. Силу затемнения, способ размытия Вашего контроллера меню.  Общий пример.

```swift
var menuViewController: UISideMenuNavigationController {
        guard let existingController = SideMenuManager.menuLeftNavigationController else {
	        // создадим, если его нет
            let sideMenuViewController = SideMenuNavigationController(rootViewController: NavigationService.menuViewController())
            sideMenuViewController.leftSide = true

            SideMenuManager.menuRightNavigationController = nil
            SideMenuManager.menuLeftNavigationController = sideMenuViewController

            sideMenuViewController.isNavigationBarHidden = true

			// произведем настройку меню
            SideMenuManager.menuPresentMode = .menuSlideIn
            SideMenuManager.menuWidth = 0.8375 * UIScreen.main.bounds.width

            SideMenuManager.menuFadeStatusBar = false

            SideMenuManager.menuAnimationFadeStrength = 0
            SideMenuManager.menuBlurEffectStyle = .extraLight
            
            return sideMenuViewController
        }

// вернем существующий контроллер, если есть
        return existingController
    }
```

- **Соединить**. Добавить распознаватели жестов на необходимые элементы интерфейса. Обычно вызывается во `viewDidLoad`

```swift
// добавляем жест на view контроллера
SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: view, forMenu: .left)

if let navigationBar = navigationController?.navigationBar {
	// добавляем жест для navigation bar
	SideMenuManager.menuAddPanGestureToPresent(toView: navigationBar)
}
```

## Открытие/Закрытие меню

Для открытия меню достаточно вызвать показ контроллера, который в `SideMenuManager.menuLeftNavigationController`. Для закрытия достаточно скрыть контроллер

```swift
func openMenu() {
	present(menuViewController, animated: true, completion: nil)
}

func closeMenu() {
	dismiss(animated: true, completion: nil)
}
```

## Переход между элементами меню

Общая концепция: смена контроллера происходит через корневой контроллер window.

<details>
<summary>Пример интерфейса для работы с сайдбаром</summary>

```swift
protocol SidebarConfigurableViewController: class {
    var enableSidebar: Bool { get }
    var menuViewController: UISideMenuNavigationController { get }

    func addSidebarGestures()

    func closeMenu()
    func openMenu()
}
```

</details>


Например, если `window.rootViewController` экземпляр класса `UINavigationController`:

```swift
// получаем корневой контроллер приложения и проверяем, что первый контроллер работает с sidebar
guard let navigationController = NavigationService.appWindow?.rootViewController as? UINavigationController,
	let rootController = navigationController.viewControllers.first as? BaseSidebarViewController else {
		return
}

// скрываем меню
rootController.closeMenu()

// не делаем ничего в случае показа этого же контроллера
guard let destinationVC = viewModel.select(menuItem),
	type(of: rootController) !== type(of: destinationVC) else {
	return
}

// переходим на новый
navigationController.setViewControllers([destinationVC], animated: false)
```

## На заметку

Если **показывать модально** контроллер поверх контроллера меню, контроллер меню скрывается. Для предотвращения этого, используйте на новом контроллере свойство `modalPresentationStyle`. 

Пример показа модального контроллера с контроллера меню.

```swift
let newController = ...
newController.modalPresentationStyle = .overFullScreen
present(newController, animated: true, completion: nil)
```

**Помните**, что не стоит добавлять распознавание жеста непосредственно на view UINavigationController. Это приведет к тому, что Вы не сможете сделать нормальный свайп назад


**Рекомендуется** вынести функциональность в extension. На всех контроллерах, которые будут работать с сайдбаром, в методе `viewDidLoad` следует вызывать добавление жестов

<details>
<summary>Полный пример extension</summary>

```swift
// ограничение на класс сделано для сравнения по type(of:)
protocol SidebarConfigurableViewController: class {

    // properties
    var enableSidebar: Bool { get }
    var menuViewController: UISideMenuNavigationController { get }

    // configuration
    func addSidebarGestures()

    // manipulation
    func closeMenu()
    func openMenu()
}

extension SidebarConfigurableViewController where Self: UIViewController {

    var enableSidebar: Bool {
        return false
    }

    var menuViewController: UISideMenuNavigationController {
        guard let existingController = SideMenuManager.menuLeftNavigationController else {
            let sideMenuViewController = SideMenuNavigationController(rootViewController: NavigationService.menuViewController())
            sideMenuViewController.leftSide = true

            SideMenuManager.menuRightNavigationController = nil
            SideMenuManager.menuLeftNavigationController = sideMenuViewController

            sideMenuViewController.isNavigationBarHidden = true

            SideMenuManager.menuPresentMode = .menuSlideIn
            SideMenuManager.menuWidth = 0.8375 * UIScreen.main.bounds.width

            SideMenuManager.menuFadeStatusBar = false

            SideMenuManager.menuAnimationFadeStrength = 0
            SideMenuManager.menuBlurEffectStyle = .extraLight
            
            return sideMenuViewController
        }

        return existingController
    }

    func addSidebarGestures() {
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: view, forMenu: .left)

        if let navigationBar = navigationController?.navigationBar {
            SideMenuManager.menuAddPanGestureToPresent(toView: navigationBar)
        }
    }

    func openMenu() {
        present(menuViewController, animated: true, completion: nil)
    }

    func closeMenu() {
        dismiss(animated: true, completion: nil)
    }

}
```

</details>


