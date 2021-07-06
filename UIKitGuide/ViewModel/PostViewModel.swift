//
//  PostViewModel.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 7/5/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import Foundation
import Combine

class PostViewModel {
   
   var postListData = CurrentValueSubject<[Post], Never>([Post]())
   var postData = CurrentValueSubject<Post, Never>(Post())
   var postAddData = CurrentValueSubject<String, Never>("")
   var subscription = Set<AnyCancellable>()
   
   init(){
      fetchListData()
   }
   
   private func fetchListData(){
      API_PostCollection.shared.getAllData()
         .receive(on: DispatchQueue.global(qos: .userInitiated))
         .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
               print("request finished")
            case .failure(let fail):
               print(fail.rawValue)
            }
         }, receiveValue: { [weak self] data in
            self?.postListData.send(data)
         }).store(in: &subscription)
   }
   
   func fetchData(param: String){
      API_PostCollection.shared.getData(param: param)
         .receive(on: DispatchQueue.global(qos: .userInitiated))
         .sink(receiveCompletion: { completion in
            switch completion {
               case .finished:
                  print("request finished")
               case .failure(let fail):
                  print(fail.rawValue)
            }
         }, receiveValue: { [weak self] data in
            self?.postData.send(data)
         }).store(in: &subscription)
   }
   
   private func addData(post: Post){
      API_PostCollection.shared.addData(post: post)
         .receive(on: DispatchQueue.global(qos: .userInitiated))
         .sink(receiveCompletion: { completion in
            switch completion {
               case .finished:
                  print("request finished")
               case .failure(let fail):
                  print(fail.rawValue)
            }
         }, receiveValue: { [weak self] data in
            self?.postAddData.send(data)
         }).store(in: &subscription)
   }
}
