enum UILoadingFullView {
    enum Loading {
        struct Request {
            let show: Bool
        }
        struct Response {
            let show: Bool
        }
        struct ViewModel {
            let show: Bool
        }
    }
    
    enum Error {
        struct Request {
            let show: Bool
            let serviceError: ServiceError?
            let customAction: (() -> Void)?
        }
        struct Response {
            let show: Bool
            let serviceError: ServiceError?
            let customAction: (() -> Void)?
        }
        struct ViewModel {
            let show: Bool
            let serviceError: ServiceError?
            let customAction: (() -> Void)?
        }
    }
}
