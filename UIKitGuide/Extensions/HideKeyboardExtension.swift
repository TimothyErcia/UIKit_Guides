//
//  HideKeyboardExtension.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/5/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
   func hideKeyboardUIView(){
      let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
      gesture.cancelsTouchesInView = true
      view.addGestureRecognizer(gesture)
   }
   
   @objc func hideKeyboard() {
       view.endEditing(true)
   }
}
