//
//  Lesson6ViewController.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/21/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import UIKit

class Lesson6ViewController: UITabBarController {
   
   private let tab1Controller = UINavigationController().setController(tab: Tab1ViewController(),
                                                                       title: "Tab 1")
   
   private let tab2Controller = UINavigationController().setController(tab: Tab3ViewController(),
                                                                       title: "Tab 2")
   
   private let tab3Controller = UINavigationController().setController(tab: Tab2ViewController(),
                                                                       title: "Tab 3")
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setViewControllers([tab1Controller, tab2Controller, tab3Controller], animated: true)
   }
}

extension UINavigationController {
   fileprivate func setController(tab: UIViewController, title: String) -> UINavigationController {
      let vc = UINavigationController(rootViewController: tab)
      vc.title = title
      vc.isNavigationBarHidden = true
      return vc
   }
}
