struct StoreInfoResponseModel: Codable {
    var name: String?
    var rating: Float?
    var openingTime: String?
    var closingTime: String?
}

struct ProductsResponseModel: Codable {
    var name: String?
    var price: Int?
    var imageUrl: String?
}

struct OrderResponseModel: Codable {
    
}
