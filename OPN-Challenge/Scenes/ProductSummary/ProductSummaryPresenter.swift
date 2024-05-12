protocol ProductSummaryPresentationLogic {
    func presentProductCartContext(response: ProductSummary.ProductCart.Response)
}

class ProductSummaryPresenter: ProductSummaryPresentationLogic {
    weak var viewController: ProductSummaryDisplayLogic?
    
    func presentProductCartContext(response: ProductSummary.ProductCart.Response) {
        let viewModel = ProductSummary.ProductCart.ViewModel(store: response.context.store, productList: filterProductCart(productList: response.context.productList), totalPrice: response.context.totalPrice, totalProduct: response.context.totalProduct, address: response.context.address)
        viewController?.displayProductCartContext(viewModel: viewModel)
    }
    
    func filterProductCart(productList: [HomeProduct.Product]) -> [HomeProduct.Product] {
        return productList.filter{$0.amount != 0}
    }
}
