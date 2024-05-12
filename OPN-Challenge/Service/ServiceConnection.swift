class ServiceConnection {
    func storeInfoService(completionHandler: @escaping (StoreInfoResponseModel) -> Void, errorHandler: @escaping (ServiceError?) -> Void) {
        BaseService().fetchStoreInfo(
            completionHandler: { (response: StoreInfoResponseModel) in
                completionHandler(response)
            }, errorHandler: { error in
                errorHandler(error)
            }
        )
    }
    
    func productsService(completionHandler: @escaping ([ProductsResponseModel]) -> Void, errorHandler: @escaping (ServiceError?) -> Void) {
        BaseService().fetchProducts(
            completionHandler: { (response: [ProductsResponseModel]) in
                completionHandler(response)
            }, errorHandler: { error in
                errorHandler(error)
            }
        )
    }
    
    func postOrderService(request: PostOrderRequestModel, completionHandler: @escaping ((OrderResponseModel) -> Void), errorHandler: @escaping (ServiceError?) -> Void) {
        BaseService().fetchPostOrder(request: request,
            completionHandler: { (response: OrderResponseModel) in
                completionHandler(response)
            }, errorHandler: { error in
                errorHandler(error)
            }
        )
    }
}
