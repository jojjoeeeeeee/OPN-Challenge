protocol HomeProductBusinessLogic {
    func updateCart(request: HomeProduct.ProductCart.Request)
    func getStoreInfoInquiry(request: HomeProduct.StoreInfoInquiry.Request)
    func getProductsInquiry(request: HomeProduct.ProductsInquiry.Request)
}

protocol HomeProductDataStore {
}

class HomeProductInteractor: HomeProductBusinessLogic, HomeProductDataStore {
    var presenter: HomeProductPresentationLogic?
    let serviceConnection: ServiceConnection
    
    init(serviceConnection: ServiceConnection = ServiceConnection()) {
        self.serviceConnection = serviceConnection
    }
    
    func updateCart(request: HomeProduct.ProductCart.Request) {
        let response = HomeProduct.ProductCart.Response(productList: request.productList, totalPrice: request.totalPrice, totalProduct: request.totalProduct)
        presenter?.presentProductCart(response: response)
    }
    
    func getStoreInfoInquiry(request: HomeProduct.StoreInfoInquiry.Request) {
        serviceConnection.storeInfoService(completionHandler: { [weak self] result in
            self?.presenter?.presentStoreInfo(
                response: HomeProduct.StoreInfoInquiry.Response(storeResponse: result)
            )
        }, errorHandler: { [weak self] error in
            self?.presenter?.presentError(
                response: HomeProduct.HomeProductError.Response(serviceError: error, customAction: request.customAction)
            )
        })
    }
    
    func getProductsInquiry(request: HomeProduct.ProductsInquiry.Request) {
        serviceConnection.productsService(completionHandler: { [weak self] result in
            self?.presenter?.presentProducts(
                response: HomeProduct.ProductsInquiry.Response(productsResponse: result)
            )
        }, errorHandler: { [weak self] error in
            self?.presenter?.presentError(
                response: HomeProduct.HomeProductError.Response(serviceError: error, customAction: request.customAction)
            )
        })
    }
}
