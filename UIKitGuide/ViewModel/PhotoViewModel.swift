//
//  PhotoListViewModel.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/11/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import Foundation
import Combine

class PhotosViewModel {
   var photos = CurrentValueSubject<[Photos], Never>([Photos]())
   var subscription = Set<AnyCancellable>()
   
   init(){
      fetchListData()
   }
   
   private func fetchListData(){
      API_PhotoCollection.shared.getAllData()
         .receive(on: DispatchQueue.global(qos: .userInitiated))
         .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
               print("request finished")
            case .failure(let error):
               print(error.rawValue)
            }
         }, receiveValue: {[weak self] (data) in
            self?.photos.send(data)
         }).store(in: &subscription)
   }
}
