import UIKit

class BaseXIBView: UIView {
    var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        let nib = UINib(nibName: String.init(describing: type(of: self)), bundle: .main)
        view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        self.layoutIfNeeded()
        addSubview(view)
    }

}
