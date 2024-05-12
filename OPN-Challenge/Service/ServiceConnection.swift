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
    
//    func CoinDetailService(uuid: String, completionHandler: @escaping (BaseCoinResponseData) -> Void, errorHandler: @escaping (ServiceError?) -> Void) {
//        let requestData = CoinDetailRequestData(uuid: uuid)
//        BaseService().fetchCoinDetail(
//            uuid: requestData.uuid,
//            completionHandler: { (response: BaseCoinResponseData) in
//                completionHandler(response)
//            }, errorHandler: { error in
//                errorHandler(error)
//            }
//        )
//    }
}
