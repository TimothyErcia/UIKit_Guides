//
//  CustomNavigationViewExtension.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/21/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
   func setController(lesson: UIViewController) -> UINavigationController{
      let vc = UINavigationController(rootViewController: lesson)
      vc.modalPresentationStyle = .fullScreen
      vc.isToolbarHidden = true
      vc.navigationBar.isHidden = true
      return vc
   }
}
