import UIKit

protocol HomeProductDisplayLogic: AnyObject {
    func displayProductCart(viewModel: HomeProduct.ProductCart.ViewModel)
    func displayStoreInfo(viewModel: HomeProduct.StoreInfoInquiry.ViewModel)
    func displayProducts(viewModel: HomeProduct.ProductsInquiry.ViewModel)
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
    @IBOutlet private weak var noProductLabel: UILabel!
    
    public var uiLoadingFullView = UILoadingFullViewViewController()
    
    var storeInfo = HomeProduct.StoreInfo(name: "", rating: "", businessHours: "")
    var productCart: [HomeProduct.Product] = []
    var totalPrice = 0
    var totalProduct = 0
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        router?.showFullViewLoading(destination: uiLoadingFullView)
        setupView()
        fetchInitialProducts()
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
        noProductLabel.isHidden = true
    }
    
    func updateCart(productList: [HomeProduct.Product], updatedPrice: Int, updatedTotalProduct: Int) {
        let request = HomeProduct.ProductCart.Request(productList: productList, totalPrice: updatedPrice, totalProduct: updatedTotalProduct)
        interactor?.updateCart(request: request)
    }
    
    func displayProductCart(viewModel: HomeProduct.ProductCart.ViewModel) {
        productCart = viewModel.productList
        totalPrice = viewModel.totalPrice
        totalProduct = viewModel.totalProduct
        productTableView.reloadData()
        enableNextButton(totalProduct > 0)
    }
    
    func displayStoreInfo(viewModel: HomeProduct.StoreInfoInquiry.ViewModel) {
        storeInfo = viewModel.storeInfo
        storeNameLabel.text = storeInfo.name
        businessHoursLabel.text = storeInfo.businessHours
        rateLabel.text = storeInfo.rating
        DispatchQueue.main.async { [weak self] in
            self?.uiLoadingFullView.interactor?.showLoading(request: UILoadingFullView.Loading.Request(show: false))
        }
    }
    
    func displayProducts(viewModel: HomeProduct.ProductsInquiry.ViewModel) {
        if viewModel.products.isEmpty {
            noProductLabel.isHidden = false
        } else {
            productCart = viewModel.products
            productTableView.reloadData()
        }
        fetchInitialStoreInfo()
    }
    
    func displayError(viewModel: HomeProduct.HomeProductError.ViewModel) {
        let serviceError = viewModel.serviceError
        let customAction = viewModel.customAction
        uiLoadingFullView.interactor?.showError(request: UILoadingFullView.Error.Request(show: true, serviceError: serviceError, customAction: customAction))
    }
    
    private func showLoadingAndFetchAgain(fetchAction: (() -> Void)?) {
        guard let action = fetchAction else { return }
        router?.showFullViewLoading(destination: uiLoadingFullView)
        action()
    }
    
    private func fetchInitialStoreInfo() {
        interactor?.getStoreInfoInquiry(request: HomeProduct.StoreInfoInquiry.Request(customAction: { [weak self] in
            self?.showLoadingAndFetchAgain(fetchAction: self?.fetchInitialStoreInfo)
        }))
    }
    
    private func fetchInitialProducts() {
        interactor?.getProductsInquiry(request: HomeProduct.ProductsInquiry.Request(customAction: { [weak self] in
            self?.showLoadingAndFetchAgain(fetchAction: self?.fetchInitialProducts)
        }))
    }
    
    private func enableNextButton(_ isEnable: Bool) {
        orderButtonStackView.backgroundColor = isEnable ? .primary : .lightGray
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.orderTotalPriceLabel.isHidden = !isEnable
        }
        orderTotalPriceLabel.text = "฿\(totalPrice)"
        orderButton.isEnabled = isEnable
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
        router?.routeToProductSummary(
            productCartContext: HomeProduct.ProductCartContext(
                store: storeInfo,
                productList: productCart,
                totalPrice: totalPrice,
                totalProduct: totalProduct,
                address: nil
            )
        )
    }
}
