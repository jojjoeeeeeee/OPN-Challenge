protocol UILoadingFullViewBusinessLogic {
    func showLoading(request: UILoadingFullView.Loading.Request)
    func showError(request: UILoadingFullView.Error.Request)
}

protocol UILoadingFullViewDataStore {
}

class UILoadingFullViewInteractor: UILoadingFullViewBusinessLogic, UILoadingFullViewDataStore {
    var presenter: UILoadingFullViewPresentationLogic?
  
    func showLoading(request: UILoadingFullView.Loading.Request) {
        presenter?.presentLoading(response: .init(show: request.show))
    }
    
    func showError(request: UILoadingFullView.Error.Request) {
        presenter?.presentError(respose: UILoadingFullView.Error.Response(show: request.show, serviceError: request.serviceError, customAction: request.customAction))
    }
}
