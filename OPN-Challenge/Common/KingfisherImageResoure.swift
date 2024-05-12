import Kingfisher

public struct KingfisherImageResource: Resource {
    public let cacheKey: String
    public let downloadURL: URL
    
    public init(downloadURL: URL, cacheKey: String? = nil) {
        self.downloadURL = downloadURL
        self.cacheKey = cacheKey ?? downloadURL.absoluteString
    }
}
