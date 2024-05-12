protocol ProductSummaryRoutingLogic {
    func showFullViewLoading(destination: UILoadingFullViewViewController)
    func routeBack(productCartContext: HomeProduct.ProductCartContext)
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

    func routeBack(productCartContext: HomeProduct.ProductCartContext) {
        guard let navigationController = viewController?.navigationController else {
            viewController?.dismiss(animated: true)
            return
        }
        
        for element in navigationController.viewControllers {
            if element.isKind(of: HomeProductViewController.self) {
                if let vc = element as? HomeProductViewController,
                   var vcDataStore = vc.router?.dataStore
                {
                    vcDataStore.productCartContext = productCartContext
                    navigationController.popToViewController(vc, animated: true)
                    break
                }
            }
        }
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func routeToOrderSuccess() {
        guard let vc = OrderSuccessViewController.initStoryboard() else { return }
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
