//
//  ProductSummaryRouter.swift
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

@objc protocol ProductSummaryRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ProductSummaryDataPassing
{
  var dataStore: ProductSummaryDataStore? { get }
}

class ProductSummaryRouter: NSObject, ProductSummaryRoutingLogic, ProductSummaryDataPassing
{
  weak var viewController: ProductSummaryViewController?
  var dataStore: ProductSummaryDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: ProductSummaryViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: ProductSummaryDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}