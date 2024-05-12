import UIKit

protocol HomeProductDisplayLogic: AnyObject {
    func displayProductList(viewModel: HomeProduct.ProductCart.ViewModel)
    func displayStoreInfo(viewModel: HomeProduct.StoreInfoInquiry.ViewModel)
    func displayError(viewModel: HomeProduct.HomeProductError.ViewModel)
}

class HomeProductViewController: UIViewController, HomeProductDisplayLogic {
    var interactor: HomeProductBusinessLogic?
    var router: (HomeProductRoutingLogic & HomeProductDataPassing)?
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var businessHoursLabel: UILabel!
    @IBOutlet private weak var storeNameLabel: UILabel!
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet private weak var bottomView: UIView!
    @IBOutlet private weak var orderTotalPriceLabel: UILabel!
    @IBOutlet private weak var orderButtonStackView: UIStackView!
    @IBOutlet private weak var orderButton: UIButton!
    
    public var uiLoadingFullView = UILoadingFullViewViewController()
    
    var productCart: [HomeProduct.Product] = [HomeProduct.Product.init(name: "Latte", price: 50, imageUrl: URL(string: "https://www.nespresso.com/ncp/res/uploads/recipes/nespresso-recipes-Latte-Art-Tulip.jpg")!, amount: 0), HomeProduct.Product.init(name: "Dark Tiramisu Mocha", price: 75, imageUrl: URL(string: "https://www.nespresso.com/shared_res/mos/free_html/sg/b2b/b2ccoffeerecipes/listing-image/image/dark-tiramisu-mocha.jpg")!, amount: 0)]
    var totalPrice = 0
    var totalProduct = 0
    
    // MARK: Object lifecycle
    
    public static func initStoryboard() -> HomeProductViewController? {
        let storyboard = UIStoryboard(name: "HomeProduct", bundle: .main)
        return storyboard.instantiateViewController(withIdentifier: "HomeProduct") as? HomeProductViewController
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = HomeProductInteractor()
        let presenter = HomeProductPresenter()
        let router = HomeProductRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchInitialStoreInfo()
    }
    
    private func setupView() {
        headerView.backgroundColor = .glass
        headerView.roundCorner(cornerRadius: 8)
        
        contentView.roundCornerTop(cornerRadius: 8)
        contentView.addShadow(
            withCornerRadius: 12,
            shadowRadius: 12,
            shadowOffset: CGSize(width: 0, height: -4),
            masksToBounds: false
        )
        
        productTableView.delegate = self
        productTableView.dataSource = self
        
        productTableView.register(
            UINib(nibName: ProductTableViewCell.identifier, bundle: .main),
            forCellReuseIdentifier: ProductTableViewCell.identifier
        )
        
        orderButtonStackView.backgroundColor = .lightGray
        orderButtonStackView.roundCorner(cornerRadius: 8)
        orderTotalPriceLabel.text = "฿\(totalPrice)"
        orderTotalPriceLabel.isHidden = true
        
        bottomView.roundCornerTop(cornerRadius: 8)
        bottomView.addShadow(
            withCornerRadius: 12,
            shadowRadius: 12,
            shadowOffset: CGSize(width: 0, height: -4),
            masksToBounds: false
        )
    }
    
    func updateCart(productList: [HomeProduct.Product], updatedPrice: Int, updatedTotalProduct: Int) {
        let request = HomeProduct.ProductCart.Request(productList: productList, totalPrice: updatedPrice, totalProduct: updatedTotalProduct)
        interactor?.updateCart(request: request)
    }
    
    func displayProductList (viewModel: HomeProduct.ProductCart.ViewModel) {
        productCart = viewModel.productList
        totalPrice = viewModel.totalPrice
        totalProduct = viewModel.totalProduct
        productTableView.reloadData()
        updateBottomView(isShow: totalProduct > 0)
    }
    
    func displayStoreInfo(viewModel: HomeProduct.StoreInfoInquiry.ViewModel) {
        let storeInfo = viewModel.storeInfo
        storeNameLabel.text = storeInfo.name
        businessHoursLabel.text = storeInfo.businessHours
        rateLabel.text = storeInfo.rating
        uiLoadingFullView.interactor?.showLoading(request: UILoadingFullView.Loading.Request(show: false))
    }
    
    func displayError(viewModel: HomeProduct.HomeProductError.ViewModel) {
        let serviceError = viewModel.serviceError
        let customAction = viewModel.customAction
        uiLoadingFullView.interactor?.showError(request: UILoadingFullView.Error.Request(show: true, serviceError: serviceError, customAction: customAction))
    }
    
    private func fetchInitialStoreInfo() {
        router?.showFullViewLoading(destination: uiLoadingFullView)
        interactor?.getStoreInfoInquiry(request: HomeProduct.StoreInfoInquiry.Request(customAction: fetchInitialStoreInfo))
    }
    
    private func updateBottomView(isShow: Bool) {
        orderButtonStackView.backgroundColor = isShow ? .primary : .lightGray
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.orderTotalPriceLabel.isHidden = !isShow
        }
        orderTotalPriceLabel.text = "฿\(totalPrice)"
        orderButton.isUserInteractionEnabled = isShow
    }
    
    func updateProduct(cellIndex: Int, isAdd: Bool = true) {
        var updatedPrice = totalPrice
        var updatedProduct = productCart
        var updatedTotalProduct = totalProduct
        if isAdd && updatedProduct[cellIndex].amount < 99 {
            updatedProduct[cellIndex].amount += 1
            updatedPrice += productCart[cellIndex].price
            updatedTotalProduct += 1
        } else if isAdd == false && updatedProduct[cellIndex].amount > 0 {
            updatedProduct[cellIndex].amount -= 1
            updatedPrice -= productCart[cellIndex].price
            updatedTotalProduct -= 1
        }
        updateCart(productList: updatedProduct, updatedPrice: updatedPrice, updatedTotalProduct: updatedTotalProduct)
    }
    
    @IBAction func onTappedOrderButton(_ sender: Any) {
        print("TappedOrder")
    }
}
