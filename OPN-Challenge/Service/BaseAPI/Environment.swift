public struct Environment {
    static let BASE_URL = "https://615dedf1-36b8-40fd-8fc4-fbc0998133cb.mock.pstmn.io"
}

extension Environment {
    enum Endpoint {
        static let storeInfo = "/storeInfo"
        static let products = "/products"
        static let order = "/order"
    }
}
