enum ProductSummary {
    
    enum ProductCart {
        struct Request {
            let context: HomeProduct.ProductCartContext
        }
        struct Response {
            let context: HomeProduct.ProductCartContext
        }
        struct ViewModel {
            let store: HomeProduct.StoreInfo
            let productList: [HomeProduct.Product]
            let totalPrice: Int
            let totalProduct: Int
            let delivery_address: String?
        }
    }
    
    enum OrderInquiry {
        struct Request {
            let productList: [HomeProduct.Product]
            let delivery_address: String
        }
        struct Response {
        }
        struct ViewModel {
        }
    }
    
    enum ProductSummaryError {
        struct Request {
        }
        struct Response {
            let serviceError: ServiceError?
        }
        struct ViewModel {
            let serviceError: ServiceError?
        }
    }
}
