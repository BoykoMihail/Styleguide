import LeadKit
import UIKit
import LeadKitAdditions

extension NavigationService {

    static func pinCodeViewController(controllerType: PassCodeControllerType,
                                      currentRootController: NavigationControllerInfo? = nil) -> PinCodeViewController {

        let controller = PinCodeViewController(nibName: PinCodeViewController.xibName, bundle: nil)
        controller.currentRootController = currentRootController
        let assembly = PinCodeAssembly(controllerType: controllerType)
        assembly.configure(input: controller)
        return controller
    }

}
