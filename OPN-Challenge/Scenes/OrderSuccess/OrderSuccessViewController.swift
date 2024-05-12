import UIKit

protocol OrderSuccessDisplayLogic: AnyObject {
    
}

class OrderSuccessViewController: UIViewController, OrderSuccessDisplayLogic {
    var interactor: OrderSuccessBusinessLogic?
    var router: (OrderSuccessRoutingLogic & OrderSuccessDataPassing)?
    
    @IBOutlet private weak var bottomStackView: UIStackView!
    @IBOutlet private weak var bottomView: UIView!
    
    public static func initStoryboard() -> OrderSuccessViewController? {
        let storyboard = UIStoryboard(name: "OrderSuccess", bundle: .main)
        return storyboard.instantiateViewController(withIdentifier: "OrderSuccess") as? OrderSuccessViewController
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = OrderSuccessInteractor()
        let presenter = OrderSuccessPresenter()
        let router = OrderSuccessRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        bottomStackView.backgroundColor = .primary
        bottomStackView.roundCorner(cornerRadius: 8)
        
        bottomView.roundCornerTop(cornerRadius: 8)
        bottomView.addShadow(
            withCornerRadius: 12,
            shadowRadius: 12,
            shadowOffset: CGSize(width: 0, height: -4),
            masksToBounds: false
        )
        
    }
    
    @IBAction func onTappedDone(_ sender: Any) {
        router?.routeToHome()
    }
}
