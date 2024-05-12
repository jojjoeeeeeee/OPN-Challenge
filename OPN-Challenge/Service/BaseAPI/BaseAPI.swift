import Moya

enum BaseAPI {
    case getStoreInfo
    case getProducts
    case postOrder(parameters: [String: Any])
}

extension BaseAPI: TargetType {
    var baseURL: URL { URL(string: Environment.BASE_URL)! }
    var path: String {
        switch self {
        case .getStoreInfo:
            return Environment.Endpoint.storeInfo
        case .getProducts:
            return Environment.Endpoint.products
        case .postOrder:
            return Environment.Endpoint.order
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getStoreInfo, .getProducts:
            return .get
        case .postOrder:
            return .post
        }
    }
    
    var task: Task {
        switch self{
        case .getProducts, .getStoreInfo:
            return .requestPlain
        case let .postOrder(parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
