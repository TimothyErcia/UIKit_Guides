//
//  Lesson3ViewController.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/2/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import UIKit

class Lesson3ViewController: UIViewController {
   
   let appBar = CustomAppBar()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      view.addSubview(appBar)
      
      view.backgroundColor = .white
      configureAppBar()
   }
   
   private func configureAppBar(){
      appBar.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 90)
      appBar.backButton.setTitle("Lesson 3", for: .normal)
      appBar.backButton.addTarget(self, action: #selector(backToHome), for: .touchUpInside)
   }
   
   @objc private func backToHome(){
      dismiss(animated: true, completion: nil)
   }
   
}
