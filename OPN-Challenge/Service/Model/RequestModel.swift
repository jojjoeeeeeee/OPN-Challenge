struct PostOrderRequestModel: Codable {
    let products: [ProductRequestModel]
    let address: String
}

struct ProductRequestModel: Codable {
    let name: String
    let price: Int
    let imageUrl: String
}
