//
//  CoreDataCollection.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/16/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import Foundation
import UIKit

class CoreDataCollection {
   
   let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

   func getAllItem(completion: @escaping ([TodoItem]) -> ()){
      do {
         let item: [TodoItem] = try context.fetch(TodoItem.fetchRequest())
         
         DispatchQueue.global(qos: .background).async {
            completion(item)
         }
      } catch {
         print("Has error")
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
         print("Has error")
      }
   }
}
