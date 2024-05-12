import UIKit

@objc protocol HomeProductRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol HomeProductDataPassing {
    var dataStore: HomeProductDataStore? { get }
}

class HomeProductRouter: NSObject, HomeProductRoutingLogic, HomeProductDataPassing {
    weak var viewController: HomeProductViewController?
    var dataStore: HomeProductDataStore?
    
    // MARK: Routing
}
