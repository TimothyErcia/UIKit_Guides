//
//  TodoListViewModel.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/16/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import Foundation
import Combine

class TodoListViewModel {
   
   var todoListData = CurrentValueSubject<[TodoItem], Never>([TodoItem]())
   var subscription = Set<AnyCancellable>()
   
   init(){
      fetchListData()
   }
   
   func fetchListData(){
      CoreDataCollection.shared.getAllItem()
         .receive(on: DispatchQueue.global(qos:.userInteractive))
         .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
               print("request finished")
            case .failure(let fail):
               print(fail.rawValue)
            }
         }, receiveValue: {[weak self] data in
            self?.todoListData.send(data)
         }).store(in: &subscription)
   }
}
