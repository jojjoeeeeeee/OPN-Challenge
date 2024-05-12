public struct BaseServiceError: Decodable {
    var name: String
    var header: String
    var message: String
}

public protocol ServiceError: Error {
    init()
    init(_ error: BaseServiceError)
    var error: BaseServiceError { get set }
}

public extension ServiceError {
    init(_ error: BaseServiceError) {
        self.init()
        self.error = error
    }
}

