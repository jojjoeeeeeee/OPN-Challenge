protocol ProductSummaryBusinessLogic {
    func getProductCartContext(request: ProductSummary.ProductCart.Request)
}

protocol ProductSummaryDataStore {
    var productCartContext: HomeProduct.ProductCartContext? { get set }
}

class ProductSummaryInteractor: ProductSummaryBusinessLogic, ProductSummaryDataStore {
    var productCartContext: HomeProduct.ProductCartContext?
    var presenter: ProductSummaryPresentationLogic?
    
    func getProductCartContext(request: ProductSummary.ProductCart.Request) {
        guard let context = productCartContext else { return }
        let response = ProductSummary.ProductCart.Response(context: context)
        presenter?.presentProductCartContext(response: response)
    }
}
