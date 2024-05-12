protocol ProductSummaryBusinessLogic {
    func getProductCartContext(request: ProductSummary.ProductCart.Request)
    func postOrderInquiry(request: ProductSummary.OrderInquiry.Request)
}

protocol ProductSummaryDataStore {
    var productCartContext: HomeProduct.ProductCartContext? { get set }
}

class ProductSummaryInteractor: ProductSummaryBusinessLogic, ProductSummaryDataStore {
    var productCartContext: HomeProduct.ProductCartContext?
    var presenter: ProductSummaryPresentationLogic?
    let serviceConnection: ServiceConnection
    
    init(serviceConnection: ServiceConnection = ServiceConnection()) {
        self.serviceConnection = serviceConnection
    }
    
    func getProductCartContext(request: ProductSummary.ProductCart.Request) {
        let response = ProductSummary.ProductCart.Response(context: request.context)
        presenter?.presentProductCartContext(response: response)
    }
    
    func postOrderInquiry(request: ProductSummary.OrderInquiry.Request) {
        let postRequest = PostOrderRequestModel(products: mapProductsRequest(productList: request.productList), delivery_address: request.delivery_address)
        serviceConnection.postOrderService(request: postRequest, completionHandler: { [weak self] result in
            self?.presenter?.presentOrderSuccess(response: ProductSummary.OrderInquiry.Response())
        }, errorHandler: { [weak self] error in
            self?.presenter?.presentError(
                response: ProductSummary.ProductSummaryError.Response(serviceError: error)
            )
        })
    }
    
    func mapProductsRequest(productList: [HomeProduct.Product]) -> [ProductRequestModel] {
        var productRequestModelArray: [ProductRequestModel] = []
        productList.forEach{ product in
            for _ in 1...product.amount {
                productRequestModelArray.append(
                    ProductRequestModel(
                        name: product.name,
                        price: product.price,
                        imageUrl: "\(product.imageUrl)"
                    )
                )
            }
        }
        return productRequestModelArray
    }
}
