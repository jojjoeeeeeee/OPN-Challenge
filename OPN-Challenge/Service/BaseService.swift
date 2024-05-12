import Moya

protocol CachePolicyGettable {
    var cachePolicy: URLRequest.CachePolicy { get }
}

final class CachePolicyPlugin: PluginType {
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        if let cachePolicyGettable = target as? CachePolicyGettable {
            var mutableRequest = request
            mutableRequest.cachePolicy = cachePolicyGettable.cachePolicy
            return mutableRequest
        }
        return request
    }
}

public class BaseService {
    private let provider: MoyaProvider<BaseAPI>
    private let requestRetrier = NetworkRequestRetrier()
    
    public init() {
        provider = MoyaProvider<BaseAPI>(
            session: Session(
                configuration: URLSessionConfiguration.default,
                startRequestsImmediately: false,
                interceptor: requestRetrier
            ),
            plugins: [CachePolicyPlugin()]
        )
    }
}

extension BaseService {
    func fetchStoreInfo(completionHandler: @escaping ((StoreInfoResponseModel) -> Void), errorHandler: @escaping (APIError) -> Void) {
        provider.request(
            BaseAPI.getStoreInfo,
            completion: { response in
                ResponseHandler().processResponse(result: response, success: completionHandler, failure: errorHandler)
            }
        )
    }
    
    func fetchProducts(completionHandler: @escaping (([ProductsResponseModel]) -> Void), errorHandler: @escaping (APIError) -> Void) {
        provider.request(
            BaseAPI.getProducts,
            completion: { response in
                ResponseHandler().processResponse(result: response, success: completionHandler, failure: errorHandler)
            }
        )
    }
    
    func fetchPostOrder(request: PostOrderRequestModel, completionHandler: @escaping ((OrderResponseModel) -> Void), errorHandler: @escaping (APIError) -> Void) {
        guard let parameters = try? JSONFormatter.shared.convertToDictionary(value: request.products) else { return }
        provider.request(
            BaseAPI.postOrder(parameters: parameters),
            completion: { response in
                ResponseHandler().processResponse(result: response, success: completionHandler, failure: errorHandler)
            }
        )
    }
}
