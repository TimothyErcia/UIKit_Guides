//
//  Lesson6ViewController.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/21/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import UIKit

class Lesson6ViewController: UITabBarController {
   
   private let appBar = CustomAppBar()
   
   private let tab1Controller = UINavigationController().setController(tab: Tab1ViewController(),
                                                                       title: "Tab 1",
                                                                       icon: "function")
   
   private let tab2Controller = UINavigationController().setController(tab: Tab3ViewController(),
                                                                       title: "Tab 2",
                                                                       icon: "house")
   
   private let tab3Controller = UINavigationController().setController(tab: Tab2ViewController(),
                                                                       title: "Tab 3",
                                                                       icon: "camera.circle")
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      view.addSubview(appBar)
      
      configureTabBar()
      configureAppbar()
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.navigationBar.barStyle = .black
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      navigationController?.navigationBar.barStyle = .default
   }
   
   private func configureTabBar(){
      setViewControllers([tab1Controller,
                          tab2Controller,
                          tab3Controller], animated: false)
      selectedIndex = 1
   }
   
   private func configureAppbar(){
      appBar.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 90)
      appBar.innerView.backgroundColor = .clear
      appBar.backButton.addTarget(self, action: #selector(backToHome), for: .touchUpInside)
      appBar.backButton.setTitle("Lesson 6", for: .normal)
   }
   
   @objc private func backToHome(){
      TransitionToRight()
   }
   
}

extension UINavigationController {
   fileprivate func setController(tab: UIViewController, title: String, icon: String) -> UINavigationController {
      let vc = UINavigationController(rootViewController: tab)
      vc.title = title
      vc.tabBarItem.image = UIImage(systemName: icon)
      vc.isNavigationBarHidden = true
      vc.modalPresentationStyle = .fullScreen
      vc.navigationBar.isHidden = true
      return vc
   }
}
