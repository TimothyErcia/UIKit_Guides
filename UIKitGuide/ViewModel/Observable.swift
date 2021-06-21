//
//  Observable.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/11/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import Foundation

class Observable<T> {
   
   var value: T? {
      didSet {
         listeners?(value)
      }
   }
   
   private var listeners: ((T?) -> Void)?
   
   init(_ value: T?){
      self.value = value
   }
   
   func bind(_ listeners: @escaping (T?) -> Void){
      listeners(self.value)
      self.listeners = listeners
   }
}
