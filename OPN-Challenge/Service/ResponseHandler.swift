import Moya

typealias NetworkFailureBlock = (APIError) -> Void

class ResponseHandler {
    func processResponse<T>(result: Result<Moya.Response, MoyaError>, success: @escaping ((T) -> Void), failure: NetworkFailureBlock?) where T: Codable {
        switch result {
        case let .success(response):
            self.validate(
                response,
                success: { () in
                    do {
                        let data = try response.map(T.self)
                        success(data)
                    } catch _ {
                        print("fail:-map")
                        failure?(APIError(
                            error: BaseServiceError(
                                name: "FAIL",
                                header: "MAPError",
                                message: "NULL_RESPONSE_MESSAGE"
                            )
                        ))
                    }
                },
                error: { error in
                    print("fail:-api", error)
                    failure?(error)
                }
            )
        case let .failure(error):
            print("fail:-validate", error)
            failure?(APIError(
                error: BaseServiceError(
                    name: "FAIL",
                    header: "NETWORKError",
                    message: "NULL_RESPONSE_MESSAGE"
                )
            ))
        }
    }
    
    func validate(_ response: Response, success: () -> Void, error: (APIError) -> Void) {
        var errorManager: APIError
        if response.statusCode >= 200 && response.statusCode < 300 {
            success()
        } else {
            do {
                let errorResponse = try response.map(ErrorResponse.self)
                print("error", errorResponse)
                errorManager = APIError(
                    error: BaseServiceError(
                        name: errorResponse.error.name,
                        header: errorResponse.error.header,
                        message: errorResponse.error.message
                    )
                )
                print("fail:-apierror-success-map-error")
            } catch {
                print("error", error)
                errorManager = APIError(
                    error: BaseServiceError(
                        name: "FAIL",
                        header: "APIError",
                        message: "NULL_RESPONSE_MESSAGE"
                    )
                )
                print("fail:-apierror-fail-map-error")
            }
            error(errorManager)
        }
    }
}
