//
//  CoreDataCollection.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/16/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import Foundation
import UIKit
import Combine

enum CoreDataError: String, Error {
   case requestError = "Error occured"
   case storageError
}

public class CoreDataCollection {
   
   static let shared = CoreDataCollection()
   
   let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
   func getAllItem() -> Future<[TodoItem], CoreDataError>{
      return Future { promise in
         do {
            let item: [TodoItem] = try self.context.fetch(TodoItem.fetchRequest())
            promise(.success(item))
         } catch {
            promise(.failure(.requestError))
         }
      }
   }
   
   func createItem(name: String, hasStatus: Bool){
      let newItem = TodoItem(context: context)
      newItem.name = name
      newItem.createdAt = Date()
      newItem.hasStatus = hasStatus
      
      saveState()
   }
   
   func deleteItem(item: TodoItem){
      context.delete(item)
      saveState()
   }
   
   func updateItem(item: TodoItem, newItem: String){
      item.name = newItem
      saveState()
   }
   
   func saveState(){
      do {
         try context.save()
      } catch {
         print(CoreDataError.requestError.rawValue)
      }
   }
}
