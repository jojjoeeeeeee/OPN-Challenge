import Foundation

enum HomeProduct {
    
    enum ProductCart {
        struct Request {
            let productList: [Product]
            let totalPrice: Int
            let totalProduct: Int
        }
        struct Response {
            let productList: [Product]
            let totalPrice: Int
            let totalProduct: Int
        }
        struct ViewModel {
            let productList: [Product]
            let totalPrice: Int
            let totalProduct: Int
        }
    }
    
    enum StoreInfoInquiry{
        struct Request {
            let customAction: (() -> Void)?
        }
        struct Response {
            let storeResponse: StoreInfoResponseModel
        }
        struct ViewModel {
            let storeInfo: StoreInfo
        }
    }
    
    enum ProductsInquiry{
        struct Request {
            let customAction: (() -> Void)?
        }
        struct Response {
            let productsResponse: [ProductsResponseModel]
        }
        struct ViewModel {
            let products: [Product]
        }
    }

    
    enum HomeProductError {
        struct Request {
        }
        struct Response {
            let serviceError: ServiceError?
            let customAction: (() -> Void)?
        }
        struct ViewModel {
            let serviceError: ServiceError?
            let customAction: (() -> Void)?
        }
    }
    
    public struct Product {
        var name: String
        var price: Int
        var imageUrl: URL
        var amount: Int
    }
    
    public struct StoreInfo {
        let name: String
        let rating: String
        let businessHours: String
    }
    
    public struct ProductCartContext {
        let store: StoreInfo
        let productList: [Product]
        let totalPrice: Int
        let totalProduct: Int
        let delivery_address: String?
    }
}
