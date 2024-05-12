import Moya
@testable import OPN_Challenge

class StubProductSummaryService: ServiceConnection {
    enum Result {
        case success, error
    }
    
    private let result: Result
    
    init(result: Result) {
        self.result = result
        super.init()
    }
    
    override func postOrderService(request: PostOrderRequestModel, completionHandler: @escaping ((OrderResponseModel) -> Void), errorHandler: @escaping ((any ServiceError)?) -> Void) {
        switch result {
        case .success:
            completionHandler(OrderResponseModel())
        case .error:
            errorHandler(APIError(error: BaseServiceError(name: "MOCK", header: "MOCK", message: "MOCK")))
        }
    }
}
