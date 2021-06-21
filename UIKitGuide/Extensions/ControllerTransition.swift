//
//  ControllerTransition.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/12/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
   func TransitionToLeft(){
      let transition: CATransition = CATransition()
      transition.duration = 0.5
      transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
      transition.type = CATransitionType.reveal
      transition.subtype = CATransitionSubtype.fromLeft
      self.view.window!.layer.add(transition, forKey: nil)
      dismiss(animated: false, completion: nil)
   }
   
   func TransitionToRight(){
      let transition: CATransition = CATransition()
      transition.duration = 0.5
      transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
      transition.type = CATransitionType.reveal
      transition.subtype = CATransitionSubtype.fromRight
      self.view.window!.layer.add(transition, forKey: nil)
      dismiss(animated: false, completion: nil)
   }
   
   func TransitionToTop(){
      let transition: CATransition = CATransition()
      transition.duration = 0.5
      transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
      transition.type = CATransitionType.reveal
      transition.subtype = CATransitionSubtype.fromTop
      self.view.window!.layer.add(transition, forKey: nil)
      dismiss(animated: false, completion: nil)
   }
   
   func TransitionToBottom(){
      let transition: CATransition = CATransition()
      transition.duration = 0.5
      transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
      transition.type = CATransitionType.reveal
      transition.subtype = CATransitionSubtype.fromBottom
      self.view.window!.layer.add(transition, forKey: nil)
      dismiss(animated: false, completion: nil)
   }
}
