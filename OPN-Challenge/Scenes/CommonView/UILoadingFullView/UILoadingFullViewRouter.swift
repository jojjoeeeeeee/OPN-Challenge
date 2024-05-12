protocol UILoadingFullViewRoutingLogic {
    func close()
}

protocol UILoadingFullViewDataPassing {
    var dataStore: UILoadingFullViewDataStore? { get }
}

class UILoadingFullViewRouter: UILoadingFullViewRoutingLogic, UILoadingFullViewDataPassing {
    weak var viewController: UILoadingFullViewViewController?
    var dataStore: UILoadingFullViewDataStore?
    
    func close() {
        viewController?.dismiss(animated: true)
    }
}
