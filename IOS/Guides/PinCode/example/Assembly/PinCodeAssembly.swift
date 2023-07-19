import LeadKit
import LeadKitAdditions

struct PinCodeAssembly {
    let controllerType: PassCodeControllerType
}

extension PinCodeAssembly: ModuleConfigurator {

    func configure(input: PinCodeViewController) {
        let touchIdService = TouchIDService()
        let viewModel = PinCodeViewModel(controllerType: controllerType,
                                         passCodeConfiguration: .defaultConfiguration,
                                         touchIdService: touchIdService)
        input.viewModel = viewModel
    }

}
