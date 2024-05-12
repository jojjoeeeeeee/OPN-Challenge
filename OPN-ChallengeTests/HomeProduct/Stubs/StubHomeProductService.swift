import Moya
@testable import OPN_Challenge

class StubHomeProductService: ServiceConnection {
    enum Result {
        case success, error
    }
    
    private let result: Result
    
    init(result: Result) {
        self.result = result
        super.init()
    }
    
    override func storeInfoService(completionHandler: @escaping (StoreInfoResponseModel) -> Void, errorHandler: @escaping ((any ServiceError)?) -> Void) {
        switch result {
        case .success:
            completionHandler(StoreInfoResponseModel(name: "TEST", rating: 5.0, openingTime: "15:01:01.772Z", closingTime: "19:45:51.365Z"))
        case .error:
            errorHandler(APIError(error: BaseServiceError(name: "MOCK", header: "MOCK", message: "MOCK")))
        }
    }
    
    override func productsService(completionHandler: @escaping (([ProductsResponseModel]) -> Void), errorHandler: @escaping ((any ServiceError)?) -> Void) {
        switch result {
        case .success:
            completionHandler([ProductsResponseModel(name: "TEST", price: 50, imageUrl: "imageURL")])
        case .error:
            errorHandler(APIError(error: BaseServiceError(name: "MOCK", header: "MOCK", message: "MOCK")))
        }
    }
}
