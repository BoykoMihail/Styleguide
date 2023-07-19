import UIKit
import LeadKit
import LeadKitAdditions
import RxSwift
import RxCocoa
import RxKeyboard

private extension PinImageType {

    var image: UIImage {
        switch self {
        case .entered:
            return // картинка с точкой
        case .clear:
            return // картинка с минусом
        }
    }

}

private extension PassCodeError {

    var errorDescription: String {
        switch self {
        case .wrongCode:
            return "Неверный ПИН. Попробуйте снова"
        case .codesNotMatch:
            return "Коды не совпадают. Попробуйте снова"
        case .tooManyAttempts:
            return "Вы превысили допустимое число попыток ввода ПИН-кода"
        }
    }

}

private extension PassCodeControllerState {

    var actionTitle: String {
        switch self {
        case .enter:
            return "Введите ПИН-код"
        case .repeatEnter:
            return "Повторите ПИН-код"
        case .oldEnter:
            return "Старый ПИН-код"
        case .newEnter:
            return "Введите новый ПИН-код"
        }
    }

}

final class PinCodeViewController: BasePassCodeViewController {

    @IBOutlet fileprivate weak var contentYConstraint: NSLayoutConstraint!

    fileprivate var sberPinViewModel: PinCodeViewModel? {
        return viewModel as? PinCodeViewModel
    }

    // MARK: - Override functions

    override var touchIdHint: String {
        return .commonPinLoginTouchIdDescription
    }

    override func imageFor(type: PinImageType) -> UIImage {
        return type.image
    }

    override func errorDescription(for error: PassCodeError) -> String {
        return error.errorDescription
    }

    override func actionTitle(for pinControllerState: PassCodeControllerState) -> String {
        return pinControllerState.actionTitle
    }

    override func showError(for error: PassCodeError) {
        if error == .tooManyAttempts {
            exit(showTooManyAttemptsAlert: true)
        } else {
            super.showError(for: error)
        }
    }

    // MARK: - Private staff

    fileprivate func rightPinUIAction() {
        let enterAction = { [weak self] in
            // Реализация смены контроллера пин кода на контроллер приложения
        }

        switch viewModel.controllerType {
        case .create:
            view.endEditing(true)
            if sberPinViewModel?.haveTouchId ?? false {
                // алерт с вопросом про использование TouchId
                // УСПЕХ: self?.sberPinViewModel?.activateTouchIdForUser()

                enterAction()
            } else {
                enterAction()
            }
        case .enter:
            enterAction()
        case .change:
            close()
        }
    }

}

// MARK: - Actions
extension PinCodeViewController {

    @objc fileprivate func exit(showTooManyAttemptsAlert: Bool = false) {
        // выйти
        if showTooManyAttemptsAlert {
            // показать алерт
        }
    }

}

// MARK: - ConfigurableController

extension PinCodeViewController {

    override func bindViews() {
        super.bindViews()

        sberPinViewModel?.pinDidReceiveAndCheck
            .drive(onNext: { [weak self] _ in
                self?.rightPinUIAction()
            })
            .addDisposableTo(disposeBag)

        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [weak self] keyboardVisibleHeight in
                guard let sSelf = self else {
                    return
                }

                let navBarHeight = sSelf.navigationController?.navigationBar.bounds.height ?? 0
                let freeSpace = sSelf.view.bounds.height - keyboardVisibleHeight - navBarHeight
                UIView.performWithoutAnimation {
                    self?.contentYConstraint.constant = -freeSpace/4
                }
            })
            .addDisposableTo(disposeBag)
    }

    override func localize() {
        super.localize()

        navigationItem.title = "ПИН-код"
    }

}
