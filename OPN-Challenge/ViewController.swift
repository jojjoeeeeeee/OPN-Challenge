//
//  ViewController.swift
//  OPN-Challenge
//
//  Created by A667209 A667209 on 12/5/2567 BE.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let vc = HomeProductViewController.initStoryboard() ?? UIViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }

}
