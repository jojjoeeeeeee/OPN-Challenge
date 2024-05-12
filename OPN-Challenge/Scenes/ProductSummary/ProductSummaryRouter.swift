protocol ProductSummaryRoutingLogic {
    func routeBack()
}

protocol ProductSummaryDataPassing {
    var dataStore: ProductSummaryDataStore? { get }
}

class ProductSummaryRouter: ProductSummaryRoutingLogic, ProductSummaryDataPassing {
    weak var viewController: ProductSummaryViewController?
    var dataStore: ProductSummaryDataStore?

    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
