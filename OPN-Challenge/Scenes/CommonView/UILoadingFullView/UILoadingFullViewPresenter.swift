protocol UILoadingFullViewPresentationLogic {
    func presentLoading(response: UILoadingFullView.Loading.Response)
    func presentError(respose: UILoadingFullView.Error.Response)
}

class UILoadingFullViewPresenter: UILoadingFullViewPresentationLogic {
    weak var viewController: UILoadingFullViewDisplayLogic?
    
    func presentLoading(response: UILoadingFullView.Loading.Response) {
        viewController?.displayLoading(viewModel: .init(show: response.show))
    }
    
    func presentError(respose: UILoadingFullView.Error.Response) {
        viewController?.displayError(viewModel: UILoadingFullView.Error.ViewModel(show: respose.show, serviceError: respose.serviceError, customAction: respose.customAction))
    }
}
