import UIKit

protocol HomeProductBusinessLogic {
    func updateCart(request: HomeProduct.ProductCart.Request)
    func getStoreInfoInquiry(request: HomeProduct.StoreInfoInquiry.Request)
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
    
    func getStoreInfoInquiry(request: HomeProduct.StoreInfoInquiry.Request) {
        ServiceConnection().storeInfoService(completionHandler: { [weak self] result in
            self?.presenter?.presentStoreInfo(
                response: HomeProduct.StoreInfoInquiry.Response(storeResponse: result)
            )
        }, errorHandler: { [weak self] error in
            self?.presenter?.presentError(
                response: HomeProduct.HomeProductError.Response(serviceError: error, customAction: request.customAction)
            )
        })
    }
}
