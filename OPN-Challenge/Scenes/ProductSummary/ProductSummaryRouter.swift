protocol ProductSummaryRoutingLogic {
    func showFullViewLoading(destination: UILoadingFullViewViewController)
    func routeBack()
    func routeToOrderSuccess()
}

protocol ProductSummaryDataPassing {
    var dataStore: ProductSummaryDataStore? { get }
}

class ProductSummaryRouter: ProductSummaryRoutingLogic, ProductSummaryDataPassing {
    weak var viewController: ProductSummaryViewController?
    var dataStore: ProductSummaryDataStore?
    
    func showFullViewLoading(destination: UILoadingFullViewViewController) {
        viewController?.present(destination, animated: true)
    }

    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func routeToOrderSuccess() {
        
    }
}
