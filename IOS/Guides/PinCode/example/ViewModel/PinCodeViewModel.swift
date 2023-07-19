import LeadKit
import RxSwift
import RxCocoa
import LeadKitAdditions

final class PinCodeViewModel: BasePassCodeViewModel {

    private let pinDidReceiveAndCheckPublisher = PublishSubject<Void>(())
    var pinDidReceiveAndCheck: Driver<Void> {
        return pinDidReceiveAndCheckPublisher.asDriver(onErrorJustReturn: ())
    }

    private let pinService = PinCodeService()

    var haveTouchId: Bool {
        return touchIdService?.canAuthenticateByTouchId ?? false
    }

    func logOut() {
        // выход из приложения
    }

    func resetPinData() {
        pinService.reset()
    }

    // MARK: - Overrided properties and functions

    override var isTouchIdEnabled: Bool {
        return pinService.isTouchIdEnabled && touchIdService?.canAuthenticateByTouchId ?? false
    }

    override func isEnteredPassCodeValid(_ passCode: String) -> Bool {
        return pinService.check(passCode: passCode)
    }

    override func authSucceed(_ type: PassCodeAuthType) {
        if controllerType == .create || controllerType == .change, case let .passCode(pin) = type {
            pinService.save(passCode: pin)
        }

        pinDidReceiveAndCheckPublisher.onNext(())
    }

    override func activateTouchIdForUser() {
        pinService.isTouchIdEnabled = true
    }

}
