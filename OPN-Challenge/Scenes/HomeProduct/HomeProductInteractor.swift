import UIKit

protocol HomeProductBusinessLogic {
    func updateCart(request: HomeProduct.ProductCart.Request)
}

protocol HomeProductDataStore {
    //var name: String { get set }
}

class HomeProductInteractor: HomeProductBusinessLogic, HomeProductDataStore {
    var presenter: HomeProductPresentationLogic?
    
    // MARK: Do something
    
    func updateCart(request: HomeProduct.ProductCart.Request) {
        let response = HomeProduct.ProductCart.Response(productList: request.productList, totalPrice: request.totalPrice, totalProduct: request.totalProduct)
        presenter?.presentProductList(response: response)
    }
}
