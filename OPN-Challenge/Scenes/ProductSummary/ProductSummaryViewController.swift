import UIKit

protocol ProductSummaryDisplayLogic: AnyObject {
    func displayProductCartContext(viewModel: ProductSummary.ProductCart.ViewModel)
    func displayError(viewModel: ProductSummary.ProductSummaryError.ViewModel)
    func displayOrderSuccess(viewModel: ProductSummary.OrderInquiry.ViewModel)
}

class ProductSummaryViewController: UIViewController, ProductSummaryDisplayLogic {
    var interactor: ProductSummaryBusinessLogic?
    var router: (ProductSummaryRoutingLogic & ProductSummaryDataPassing)?
    
    @IBOutlet private weak var backButtonImageView: UIImageView!
    @IBOutlet private weak var screenTitleLabel: UILabel!
    @IBOutlet weak var productListTableView: UITableView!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet private weak var totalPriceLabel: UILabel!
    @IBOutlet private weak var bottomView: UIView!
    @IBOutlet private weak var orderButtonStackView: UIStackView!
    @IBOutlet private weak var bottomTotalPriceLabel: UILabel!
    @IBOutlet private weak var nextButton: UIButton!
    
    public var uiLoadingFullView = UILoadingFullViewViewController()
    
    var productCart: [HomeProduct.Product] = []
    var totalPrice = 0
    var totalProduct = 0
    
    public static func initStoryboard() -> ProductSummaryViewController? {
        let storyboard = UIStoryboard(name: "ProductSummary", bundle: .main)
        return storyboard.instantiateViewController(withIdentifier: "ProductSummary") as? ProductSummaryViewController
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let viewController = self
        let interactor = ProductSummaryInteractor()
        let presenter = ProductSummaryPresenter()
        let router = ProductSummaryRouter()
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
        initialDataFromProductCartContext()
    }
    
    private func setupView() {
        navigationController?.navigationBar.isHidden = true
        
        let onTapBackGesture = UITapGestureRecognizer(target: self, action: #selector(onTapBack))
        backButtonImageView.isUserInteractionEnabled = true
        backButtonImageView.addGestureRecognizer(onTapBackGesture)
        
        productListTableView.delegate = self
        productListTableView.dataSource = self
        
        productListTableView.register(
            UINib(nibName: ProductTableViewCell.identifier, bundle: .main),
            forCellReuseIdentifier: ProductTableViewCell.identifier
        )
        
        orderButtonStackView.roundCorner(cornerRadius: 8)
        
        bottomView.roundCornerTop(cornerRadius: 8)
        bottomView.addShadow(
            withCornerRadius: 12,
            shadowRadius: 12,
            shadowOffset: CGSize(width: 0, height: -4),
            masksToBounds: false
        )
        
        addressTextView.delegate = self
        addressTextView.roundCorner(cornerRadius: 8)
        addressTextView.layer.borderWidth = 1
        addressTextView.layer.borderColor = UIColor.lightGreyPrimary.cgColor
        addressTextView.text = "Please fill in address..."
        addressTextView.textColor = UIColor.lightGreySecondary
        enableNextButton(false)
        
        let tapGestureDismissKeyboard = UITapGestureRecognizer(target: self, action: #selector(onTapDismissKeyboard))
        view.addGestureRecognizer(tapGestureDismissKeyboard)
    }
    
    private func initialDataFromProductCartContext() {
        guard let context = router?.dataStore?.productCartContext else { return }
        interactor?.getProductCartContext(request: ProductSummary.ProductCart.Request(context: context))
    }
    
    @objc private func onTapDismissKeyboard() {
        addressTextView.resignFirstResponder()
    }
    
    @objc private func onTapBack() {
        router?.routeBack()
    }
    
    func enableNextButton(_ isEnable: Bool) {
        orderButtonStackView.backgroundColor = isEnable ? .primary : .lightGray
        nextButton.isEnabled = isEnable
    }
    
    func displayProductCartContext(viewModel: ProductSummary.ProductCart.ViewModel) {
        let store = viewModel.store
        let productList = viewModel.productList
        
        screenTitleLabel.text = "\(store.name) - Order"
        productCart = productList
        totalPrice = viewModel.totalPrice
        totalProduct = viewModel.totalProduct
        
        totalPriceLabel.text = "฿\(totalPrice)"
        bottomTotalPriceLabel.text = "฿\(totalPrice)"
        productListTableView.reloadData()
    }
    
    func displayError(viewModel: ProductSummary.ProductSummaryError.ViewModel) {
        let serviceError = viewModel.serviceError
        uiLoadingFullView.interactor?.showError(request: UILoadingFullView.Error.Request(show: true, serviceError: serviceError, customAction: nil))
    }
    
    func displayOrderSuccess(viewModel: ProductSummary.OrderInquiry.ViewModel) {
        router?.routeToOrderSuccess()
    }
    
    @IBAction func onTappedOrder(_ sender: Any) {
        router?.showFullViewLoading(destination: uiLoadingFullView)
        interactor?.postOrderInquiry(request: ProductSummary.OrderInquiry.Request(
            productList: productCart, delivery_address: addressTextView.text)
        )
    }
}
