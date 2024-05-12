import UIKit

enum HomeProduct {
    // MARK: Use cases
    
    enum ProductCart {
        struct Request {
            var productList: [Product]
            var totalPrice: Int
            var totalProduct: Int
        }
        struct Response {
            var productList: [Product]
            var totalPrice: Int
            var totalProduct: Int
        }
        struct ViewModel {
            var productList: [Product]
            var totalPrice: Int
            var totalProduct: Int
        }
    }
    
    public struct Product {
        var name: String
        var price: Int
        var imageUrl: URL
        var amount: Int
    }
}
