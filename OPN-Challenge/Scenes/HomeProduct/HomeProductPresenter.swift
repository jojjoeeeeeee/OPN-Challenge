import UIKit

protocol HomeProductPresentationLogic {
    func presentProductList(response: HomeProduct.ProductCart.Response)
}

class HomeProductPresenter: HomeProductPresentationLogic {
    weak var viewController: HomeProductDisplayLogic?
    
    // MARK: Do something
    
    func presentProductList(response: HomeProduct.ProductCart.Response) {
        let viewModel = HomeProduct.ProductCart.ViewModel(productList: response.productList, totalPrice: response.totalPrice, totalProduct: response.totalProduct)
        viewController?.displayProductList(viewModel: viewModel)
    }
}
