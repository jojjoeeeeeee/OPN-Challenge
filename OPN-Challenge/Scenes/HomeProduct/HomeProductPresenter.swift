import Foundation

protocol HomeProductPresentationLogic {
    func presentProductCart(response: HomeProduct.ProductCart.Response)
    func presentStoreInfo(response: HomeProduct.StoreInfoInquiry.Response)
    func presentProducts(response: HomeProduct.ProductsInquiry.Response)
    func presentError(response: HomeProduct.HomeProductError.Response)
}

class HomeProductPresenter: HomeProductPresentationLogic {
    weak var viewController: HomeProductDisplayLogic?
    
    func presentProductCart(response: HomeProduct.ProductCart.Response) {
        let viewModel = HomeProduct.ProductCart.ViewModel(productList: response.productList, totalPrice: response.totalPrice, totalProduct: response.totalProduct)
        viewController?.displayProductCart(viewModel: viewModel)
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
    
    func presentProducts(response: HomeProduct.ProductsInquiry.Response) {
        let mappedProducts = mapProducts(productResponse: response.productsResponse) ?? []
        let viewModel = HomeProduct.ProductsInquiry.ViewModel(products: mappedProducts)
        viewController?.displayProducts(viewModel: viewModel)
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
    
    func mapProducts(productResponse: [ProductsResponseModel]) -> [HomeProduct.Product]? {
        return productResponse.compactMap{ product -> HomeProduct.Product? in
            if let imageUrl = URL(string: product.imageUrl ?? ""), let name = product.name, let price = product.price {
                return HomeProduct.Product(
                    name: name,
                    price: price,
                    imageUrl: imageUrl,
                    amount: 0
                )
            } else {
                return nil
            }
        }
    }
}
