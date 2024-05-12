protocol HomeProductRoutingLogic {
    func showFullViewLoading(destination: UILoadingFullViewViewController)
    func routeToProductSummary(productCartContext: HomeProduct.ProductCartContext)
}

protocol HomeProductDataPassing {
    var dataStore: HomeProductDataStore? { get }
}

class HomeProductRouter: HomeProductRoutingLogic, HomeProductDataPassing {
    weak var viewController: HomeProductViewController?
    var dataStore: HomeProductDataStore?
    
    func showFullViewLoading(destination: UILoadingFullViewViewController) {
        viewController?.present(destination, animated: true)
    }
    
    func routeToProductSummary(productCartContext: HomeProduct.ProductCartContext) {
        guard let vc = ProductSummaryViewController.initStoryboard() else { return }
        guard var vcDataStore = vc.router?.dataStore else {
            return
        }
        vcDataStore.productCartContext = productCartContext
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
