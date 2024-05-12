//
//  ProductSummaryInteractor.swift
//  OPN-Challenge
//
//  Created by A667209 A667209 on 12/5/2567 BE.
//  Copyright (c) 2567 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ProductSummaryBusinessLogic
{
  func doSomething(request: ProductSummary.Something.Request)
}

protocol ProductSummaryDataStore
{
  //var name: String { get set }
}

class ProductSummaryInteractor: ProductSummaryBusinessLogic, ProductSummaryDataStore
{
  var presenter: ProductSummaryPresentationLogic?
  var worker: ProductSummaryWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: ProductSummary.Something.Request)
  {
    worker = ProductSummaryWorker()
    worker?.doSomeWork()
    
    let response = ProductSummary.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
