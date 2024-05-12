enum ProductSummary {
    
    enum ProductCart {
        struct Request {
        }
        struct Response {
            let context: HomeProduct.ProductCartContext
        }
        struct ViewModel {
            let store: HomeProduct.StoreInfo
            let productList: [HomeProduct.Product]
            let totalPrice: Int
            let totalProduct: Int
            let address: String?
        }
    }
}
