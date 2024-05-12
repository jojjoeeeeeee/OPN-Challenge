public class APIError: ServiceError {
    public var error: BaseServiceError = BaseServiceError(name: "", header: "", message: "")
    public required init() {}
    
    public required init(error: BaseServiceError) {
        self.error = error
    }
}

struct ErrorResponse: Decodable {
    var error: BaseServiceError
}
