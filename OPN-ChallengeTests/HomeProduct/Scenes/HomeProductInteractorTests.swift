@testable import OPN_Challenge
import XCTest

class HomeProductInteractorTests: XCTestCase {
    var sut: HomeProductInteractor?
    
    override func setUp() {
        super.setUp()
        sut = HomeProductInteractor()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_updateCart() {
        let spy = SpyHomeProductPresenter()
        let stub = StubHomeProductService(result: .success)
        sut = HomeProductInteractor(serviceConnection: stub)
        sut?.presenter = spy
        sut?.updateCart(
            request: HomeProduct.ProductCart.Request(
                productList: [],
                totalPrice: 0,
                totalProduct: 0
            )
        )
        XCTAssertTrue(spy.presentProductCartCalled)
    }
    
    func test_presentStoreInfo_success() {
        let spy = SpyHomeProductPresenter()
        let stub = StubHomeProductService(result: .success)
        sut = HomeProductInteractor(serviceConnection: stub)
        sut?.presenter = spy
        sut?.getStoreInfoInquiry(request: HomeProduct.StoreInfoInquiry.Request(customAction: nil))
        XCTAssertTrue(spy.presentStoreInfoCalled)
    }
    
    func test_presentStoreInfo_error() {
        let spy = SpyHomeProductPresenter()
        let stub = StubHomeProductService(result: .error)
        sut = HomeProductInteractor(serviceConnection: stub)
        sut?.presenter = spy
        sut?.getStoreInfoInquiry(request: HomeProduct.StoreInfoInquiry.Request(customAction: nil))
        XCTAssertTrue(spy.presentErrorCalled)
    }
    
    func test_presentProducts_success() {
        let spy = SpyHomeProductPresenter()
        let stub = StubHomeProductService(result: .success)
        sut = HomeProductInteractor(serviceConnection: stub)
        sut?.presenter = spy
        sut?.getProductsInquiry(request: HomeProduct.ProductsInquiry.Request(customAction: nil))
        XCTAssertTrue(spy.presentProductsCalled)
    }
    
    func test_presentProducts_error() {
        let spy = SpyHomeProductPresenter()
        let stub = StubHomeProductService(result: .error)
        sut = HomeProductInteractor(serviceConnection: stub)
        sut?.presenter = spy
        sut?.getProductsInquiry(request: HomeProduct.ProductsInquiry.Request(customAction: nil))
        XCTAssertTrue(spy.presentErrorCalled)
    }

    func test_handleCallBack_orderSuccess() {
        let spy = SpyHomeProductPresenter()
        let stub = StubHomeProductService(result: .error)
        sut = HomeProductInteractor(serviceConnection: stub)
        sut?.presenter = spy
        sut?.handleCallBack(request: HomeProduct.HomeProductCallBackFlow.Request(callBack: .orderSuccess))
        XCTAssertTrue(spy.presentBeginFetchFlowCalled)
    }
    
    func test_handleCallBack_none() {
        let spy = SpyHomeProductPresenter()
        let stub = StubHomeProductService(result: .error)
        sut = HomeProductInteractor(serviceConnection: stub)
        sut?.presenter = spy
        sut?.handleCallBack(request: HomeProduct.HomeProductCallBackFlow.Request(callBack: nil))
        XCTAssertFalse(spy.presentBeginFetchFlowCalled)
    }
}

extension HomeProductInteractorTests {
    class SpyHomeProductPresenter: HomeProductPresentationLogic {
        var presentProductCartCalled = false
        var presentStoreInfoCalled = false
        var presentProductsCalled = false
        var presentErrorCalled = false
        var presentBeginFetchFlowCalled = false
        
        func presentProductCart(response: OPN_Challenge.HomeProduct.ProductCart.Response) {
            presentProductCartCalled = true
        }
        
        func presentStoreInfo(response: OPN_Challenge.HomeProduct.StoreInfoInquiry.Response) {
            presentStoreInfoCalled = true
        }
        
        func presentProducts(response: OPN_Challenge.HomeProduct.ProductsInquiry.Response) {
            presentProductsCalled = true
        }
        
        func presentError(response: OPN_Challenge.HomeProduct.HomeProductError.Response) {
            presentErrorCalled = true
        }
        
        func presentBeginFetchFlow(response: HomeProduct.HomeProductCallBackFlow.Response) {
            presentBeginFetchFlowCalled = true
        }
    }
}
