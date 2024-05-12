import UIKit

protocol UILoadingFullViewDisplayLogic: AnyObject {
    func displayLoading(viewModel: UILoadingFullView.Loading.ViewModel)
    func displayError(viewModel: UILoadingFullView.Error.ViewModel)
}

class UILoadingFullViewViewController: UIViewController, UILoadingFullViewDisplayLogic {
    var interactor: UILoadingFullViewBusinessLogic?
    var router: (UILoadingFullViewRoutingLogic & UILoadingFullViewDataPassing)?
    
    @IBOutlet private weak var errorViewContainer: UIView!
    @IBOutlet private weak var errorHeader: UILabel!
    @IBOutlet private weak var errorMessage: UILabel!
    @IBOutlet private weak var errorName: UILabel!
    @IBOutlet private weak var loadingView: UIImageView!
    
    var customAction: (() -> Void)?
    
    init() {
        super.init(nibName: "UILoadingFullView", bundle: .main)
        configure(viewController: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure(viewController: self)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        configure(viewController: self)
    }

    func configure(viewController: UILoadingFullViewViewController) {
        let interactor = UILoadingFullViewInteractor()
        let presenter = UILoadingFullViewPresenter()
        let router = UILoadingFullViewRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.isHidden = false
    }
    
    private func setupView() {
        view.backgroundColor = .black.withAlphaComponent(0.7)
        view.layoutIfNeeded()
        rotateView(targetView: loadingView)
        errorViewContainer.isHidden = true
    }
    
    func displayLoading(viewModel: UILoadingFullView.Loading.ViewModel) {
        errorViewContainer.isHidden = true
        if (!viewModel.show) {
            router?.close()
        }
    }
    
    func displayError(viewModel: UILoadingFullView.Error.ViewModel) {
        errorViewContainer.isHidden = !viewModel.show
        errorHeader.text = viewModel.serviceError?.error.header
        errorMessage.text = viewModel.serviceError?.error.message
        errorName.text = "[\(viewModel.serviceError?.error.name ?? "")]"
        customAction = viewModel.customAction
    }
    
    private func rotateView(targetView: UIView, duration: Double = 3) {
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: { targetView.transform = targetView.transform.rotated(by: .pi-360)
        }) { finished in
            self.rotateView(targetView: targetView, duration: duration)
        }
    }
    
    @IBAction func onTappedTryAgain(_ sender: Any) {
        guard let action = customAction else { return }
        view.isHidden = true
        errorViewContainer.isHidden = true
        router?.close()
        action()
    }
}
