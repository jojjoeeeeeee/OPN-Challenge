struct PostOrderRequestModel: Codable {
    let products: [ProductRequestModel]
    let delivery_address: String
}

struct ProductRequestModel: Codable {
    let name: String
    let price: Int
    let imageUrl: String
}
