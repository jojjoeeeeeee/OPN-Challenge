protocol ProductSummaryPresentationLogic {
    func presentProductCartContext(response: ProductSummary.ProductCart.Response)
    func presentError(response: ProductSummary.ProductSummaryError.Response)
    func presentOrderSuccess(response: ProductSummary.OrderInquiry.Response)
}

class ProductSummaryPresenter: ProductSummaryPresentationLogic {
    weak var viewController: ProductSummaryDisplayLogic?
    
    func presentProductCartContext(response: ProductSummary.ProductCart.Response) {
        let viewModel = ProductSummary.ProductCart.ViewModel(store: response.context.store, productList: filterProductCart(productList: response.context.productList), totalPrice: response.context.totalPrice, totalProduct: response.context.totalProduct, delivery_address: response.context.delivery_address)
        viewController?.displayProductCartContext(viewModel: viewModel)
    }
    
    func filterProductCart(productList: [HomeProduct.Product]) -> [HomeProduct.Product] {
        return productList.filter{$0.amount != 0}
    }
    
    func presentError(response: ProductSummary.ProductSummaryError.Response) {
        let viewModel = ProductSummary.ProductSummaryError.ViewModel(serviceError: response.serviceError)
        viewController?.displayError(viewModel: viewModel)
    }
    
    func presentOrderSuccess(response: ProductSummary.OrderInquiry.Response) {
        viewController?.displayOrderSuccess(viewModel: ProductSummary.OrderInquiry.ViewModel())
    }
}
