import UIKit
import Kingfisher

class ImageUtils {
    static func setImageWithUrl(
        imageView: UIImageView,
        url: URL?,
        placeholder: UIImage? = UIImage(named: "placeholder", in: .main, compatibleWith: nil),
        progressBlock: ((_ receivedSize: Int64, _ totalSize: Int64) -> Void)? = nil,
        completionHandler: ((UIImage?) -> Void)? = nil
    ) {
        guard let url = url else {
            imageView.image = placeholder
            completionHandler?(nil)
            return
        }
        
        let resource = KingfisherImageResource(downloadURL: url)
        imageView.kf.setImage(
            with: resource,
            placeholder: placeholder,
            options: [.cacheOriginalImage],
            progressBlock: progressBlock,
            completionHandler: { result in
                switch result {
                case .success(let image):
                    completionHandler?(image.image)
                case .failure(let error):
                    imageView.image = placeholder
                }
            })
    }
}
