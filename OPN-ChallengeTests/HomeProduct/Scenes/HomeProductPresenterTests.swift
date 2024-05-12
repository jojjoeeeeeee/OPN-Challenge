@testable import OPN_Challenge
import XCTest

class HomeProductPresenterTests: XCTestCase {
    var sut: HomeProductPresenter?
    
    override func setUp() {
        super.setUp()
        sut = HomeProductPresenter()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_presentProductCart() {
        let spy = SpyHomeProductDisplay()
        sut?.viewController = spy
        sut?.presentProductCart(response: HomeProduct.ProductCart.Response(productList: [], totalPrice: 0, totalProduct: 0))
        XCTAssertTrue(spy.displayProductCartCalled)
    }
    
    func test_presentStoreInfo() {
        let spy = SpyHomeProductDisplay()
        sut?.viewController = spy
        sut?.presentStoreInfo(response: HomeProduct.StoreInfoInquiry.Response(storeResponse: StoreInfoResponseModel()))
        XCTAssertTrue(spy.displayStoreInfoCalled)
    }
    
    func test_presentProducts() {
        let spy = SpyHomeProductDisplay()
        sut?.viewController = spy
        sut?.presentProducts(response: HomeProduct.ProductsInquiry.Response(productsResponse: []))
        XCTAssertTrue(spy.displayProductsCalled)
    }
    
    func test_presentError() {
        let spy = SpyHomeProductDisplay()
        sut?.viewController = spy
        sut?.presentError(response: HomeProduct.HomeProductError.Response(serviceError: APIError(error: BaseServiceError(name: "MOCK", header: "MOCK", message: "MOCK")), customAction: nil))
        XCTAssertTrue(spy.displayErrorCalled)
    }
    
}

extension HomeProductPresenterTests {
    class SpyHomeProductDisplay: HomeProductDisplayLogic {
        var displayProductCartCalled = false
        var displayStoreInfoCalled = false
        var displayProductsCalled = false
        var displayErrorCalled = false
        
        func displayProductCart(viewModel: OPN_Challenge.HomeProduct.ProductCart.ViewModel) {
            displayProductCartCalled = true
        }
        
        func displayStoreInfo(viewModel: OPN_Challenge.HomeProduct.StoreInfoInquiry.ViewModel) {
            displayStoreInfoCalled = true
        }
        
        func displayProducts(viewModel: OPN_Challenge.HomeProduct.ProductsInquiry.ViewModel) {
            displayProductsCalled = true
        }
        
        func displayError(viewModel: OPN_Challenge.HomeProduct.HomeProductError.ViewModel) {
            displayErrorCalled = true
        }
        
    }
}
