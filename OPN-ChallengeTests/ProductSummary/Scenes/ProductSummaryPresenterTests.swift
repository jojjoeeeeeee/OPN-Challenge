@testable import OPN_Challenge
import XCTest

class ProductSummaryPresenterTests: XCTestCase {
    var sut: ProductSummaryPresenter?
    
    override func setUp() {
        super.setUp()
        sut = ProductSummaryPresenter()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_presentProductCartContext() {
        let spy = SpyProductSummaryDisplay()
        sut?.viewController = spy
        sut?.presentProductCartContext(
            response: ProductSummary.ProductCart.Response(
                context: HomeProduct.ProductCartContext(
                    store: HomeProduct.StoreInfo(
                            name: "",
                            rating: "",
                            businessHours: ""
                        ),
                    productList: [],
                    totalPrice: 0,
                    totalProduct: 0,
                    delivery_address: ""
                )
            )
        )
        XCTAssertTrue(spy.displayProductCartContextCalled)
    }
    
    func test_presentOrderSuccess() {
        let spy = SpyProductSummaryDisplay()
        sut?.viewController = spy
        sut?.presentOrderSuccess(response: ProductSummary.OrderInquiry.Response())
        XCTAssertTrue(spy.displayOrderSuccssCalled)
    }
    
    func test_presentError() {
        let spy = SpyProductSummaryDisplay()
        sut?.viewController = spy
        sut?.presentError(
            response: ProductSummary.ProductSummaryError.Response(
                serviceError: APIError(
                    error: BaseServiceError(
                        name: "MOCK",
                        header: "MOCK",
                        message: "MOCK"
                    )
                )
            )
        )
        XCTAssertTrue(spy.displayErrorCalled)
    }
    
}

extension ProductSummaryPresenterTests {
    class SpyProductSummaryDisplay: ProductSummaryDisplayLogic {
        var displayErrorCalled = false
        var displayProductCartContextCalled = false
        var displayOrderSuccssCalled = false
        
        func displayError(viewModel: OPN_Challenge.ProductSummary.ProductSummaryError.ViewModel) {
            displayErrorCalled = true
        }
        
        func displayProductCartContext(viewModel: OPN_Challenge.ProductSummary.ProductCart.ViewModel) {
            displayProductCartContextCalled = true
        }
        
        func displayOrderSuccess(viewModel: OPN_Challenge.ProductSummary.OrderInquiry.ViewModel) {
            displayOrderSuccssCalled = true
        }
    }
}
