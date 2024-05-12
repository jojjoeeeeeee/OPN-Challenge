protocol OrderSuccessRoutingLogic {
    func routeToHome()
}

protocol OrderSuccessDataPassing {
    var dataStore: OrderSuccessDataStore? { get }
}

class OrderSuccessRouter: OrderSuccessRoutingLogic, OrderSuccessDataPassing {
    weak var viewController: OrderSuccessViewController?
    var dataStore: OrderSuccessDataStore?
    
    func routeToHome() {
        guard let navigationController = viewController?.navigationController else {
            viewController?.dismiss(animated: true)
            return
        }
        
        for element in navigationController.viewControllers {
            if element.isKind(of: HomeProductViewController.self) {
                if let vc = element as? HomeProductViewController,
                    var vcDataStore = vc.router?.dataStore
                {
                    vcDataStore.callBack = .orderSuccess
                    vcDataStore.productCartContext = nil
                    navigationController.popToViewController(vc, animated: true)
                    break
                }
            }
        }
    }
}
