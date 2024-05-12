@testable import OPN_Challenge
import XCTest

class ProductSummaryInteractorTests: XCTestCase {
    var sut: ProductSummaryInteractor?
    
    override func setUp() {
        super.setUp()
        sut = ProductSummaryInteractor()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_getProductCartContext() {
        let spy = SpyProductSummaryPresenter()
        let stub = StubProductSummaryService(result: .success)
        sut = ProductSummaryInteractor(serviceConnection: stub)
        sut?.presenter = spy
        sut?.getProductCartContext(
            request: ProductSummary.ProductCart.Request(
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
        XCTAssertTrue(spy.presentProductCartContextCalled)
    }
    
    func test_postOrderInquiry_success() {
        let spy = SpyProductSummaryPresenter()
        let stub = StubProductSummaryService(result: .success)
        sut = ProductSummaryInteractor(serviceConnection: stub)
        sut?.presenter = spy
        sut?.postOrderInquiry(request: ProductSummary.OrderInquiry.Request(productList: [], delivery_address: ""))
        XCTAssertTrue(spy.presentOrderSuccessCalled)
    }
    
    func test_postOrderInquiry_error() {
        let spy = SpyProductSummaryPresenter()
        let stub = StubProductSummaryService(result: .error)
        sut = ProductSummaryInteractor(serviceConnection: stub)
        sut?.presenter = spy
        sut?.postOrderInquiry(request: ProductSummary.OrderInquiry.Request(productList: [], delivery_address: ""))
        XCTAssertTrue(spy.presentErrorCalled)
    }

}

extension ProductSummaryInteractorTests {
    class SpyProductSummaryPresenter: ProductSummaryPresentationLogic {
        var presentProductCartContextCalled = false
        var presentErrorCalled = false
        var presentOrderSuccessCalled = false
        
        func presentProductCartContext(response: OPN_Challenge.ProductSummary.ProductCart.Response) {
            presentProductCartContextCalled = true
        }
        
        func presentError(response: OPN_Challenge.ProductSummary.ProductSummaryError.Response) {
            presentErrorCalled = true
        }
        
        func presentOrderSuccess(response: OPN_Challenge.ProductSummary.OrderInquiry.Response) {
            presentOrderSuccessCalled = true
        }
    }
}
