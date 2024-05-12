import UIKit

protocol OrderSuccessBusinessLogic {
}

protocol OrderSuccessDataStore{
}

class OrderSuccessInteractor: OrderSuccessBusinessLogic, OrderSuccessDataStore {
    var presenter: OrderSuccessPresentationLogic?
    
}
