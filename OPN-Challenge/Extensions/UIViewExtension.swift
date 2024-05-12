import UIKit

public extension UIView {
    
    func roundCorner(cornerRadius: CGFloat = 16.0) {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
    
    func roundCornerTopAndBottom(cornerRadius: CGFloat = 16.0, borderWidth: CGFloat = 0) {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    // MARK: - set corner some side
    func roundCornerTop(cornerRadius: CGFloat = 16.0, borderWidth: CGFloat = 0) {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func roundCornerBottom(cornerRadius: CGFloat = 16.0, borderWidth: CGFloat = 0) {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func addShadow(
        withCornerRadius cornerRadius: CGFloat = 0,
        withShadowColor color: UIColor = .black,
        withShadowOpacity opacity: Float = 0.1,
        shadowRadius: CGFloat = 3,
        shadowOffset: CGSize = CGSize(width: 0, height: 2),
        masksToBounds: Bool = true
    ) {
        layer.masksToBounds = masksToBounds
        layer.cornerRadius = cornerRadius
        layer.shadowColor = color.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = opacity
    }
}
