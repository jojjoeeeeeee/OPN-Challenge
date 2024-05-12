import UIKit

protocol HomeProductPresentationLogic {
    func presentProductList(response: HomeProduct.ProductCart.Response)
    func presentStoreInfo(response: HomeProduct.StoreInfoInquiry.Response)
    func presentError(response: HomeProduct.HomeProductError.Response)
}

class HomeProductPresenter: HomeProductPresentationLogic {
    weak var viewController: HomeProductDisplayLogic?
    
    // MARK: Do something
    
    func presentProductList(response: HomeProduct.ProductCart.Response) {
        let viewModel = HomeProduct.ProductCart.ViewModel(productList: response.productList, totalPrice: response.totalPrice, totalProduct: response.totalProduct)
        viewController?.displayProductList(viewModel: viewModel)
    }
    
    func presentStoreInfo(response: HomeProduct.StoreInfoInquiry.Response) {
        let formattedTime = "\(formatBusinessTime(dateString: response.storeResponse.openingTime ?? "")) - \(formatBusinessTime(dateString: response.storeResponse.closingTime ?? ""))"
        let formattedRate = formatStoreRating(rate: response.storeResponse.rating ?? 0.0)
        let viewModel = HomeProduct.StoreInfoInquiry.ViewModel(
            storeInfo: HomeProduct.StoreInfo(
                name: response.storeResponse.name ?? "",
                rating: formattedRate,
                businessHours: formattedTime
            )
        )
        viewController?.displayStoreInfo(viewModel: viewModel)
    }
    
    func presentError(response: HomeProduct.HomeProductError.Response) {
        let viewModel = HomeProduct.HomeProductError.ViewModel(serviceError: response.serviceError, customAction: response.customAction)
        viewController?.displayError(viewModel: viewModel)
    }
    
    func formatBusinessTime(dateString: String) -> String {
        return DateFormatComponent().format(dateString: dateString, sourcePattern: .HH_mm_ss_SSSS_Z, destinationPattern: .HH_mm)
    }
    
    func formatStoreRating(rate: Float) -> String {
        return String(format: "%.1f", rate)
    }
}
