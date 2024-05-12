protocol HomeProductRoutingLogic {
    func showFullViewLoading(destination: UILoadingFullViewViewController)
}

protocol HomeProductDataPassing {
    var dataStore: HomeProductDataStore? { get }
}

class HomeProductRouter: HomeProductRoutingLogic, HomeProductDataPassing {
    weak var viewController: HomeProductViewController?
    var dataStore: HomeProductDataStore?
    
    // MARK: Routing
    public func showFullViewLoading(destination: UILoadingFullViewViewController) {
        viewController?.present(destination, animated: true)
    }
}
