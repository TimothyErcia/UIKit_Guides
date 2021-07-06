//
//  APICollectionTest.swift
//  UIKitGuideTests
//
//  Created by Timothy Ercia on 7/6/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import Foundation
import XCTest
import Combine
@testable import UIKitGuide

class APICollectionTest: XCTestCase {
   private var subcription = Set<AnyCancellable>()
   
   override func tearDown() {
      subcription = []
   }
   
   //API Collection Test
   func testGetAllData() {
      //Call API
      let fetchData = API_PostCollection.shared.getAllData()
      fetchData.sink(receiveCompletion: { completion in
         switch completion {
         case .finished:
            XCTAssertNotNil(completion)
         case .failure(_):
            XCTFail()
         }
      }, receiveValue: { data in
         
         XCTAssertNil(data)
      }).store(in: &subcription)
   }
   
   func testGetData(){
      
   }
   
   func testAddData(){
      
   }
   
   
}
