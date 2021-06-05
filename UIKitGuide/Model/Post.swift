//
//  Post.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/5/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import Foundation

struct Post: Codable, Identifiable {
   var id: Int
   var userId: Int
   var title: String
   var body: String
}

class APICollection {
   func getAllData(completion: @escaping ([Post]) -> ()){
      guard let url = URL(string: Constants().MAIN_URL + "post") else { return }
      
      var request = URLRequest(url: url)
      request.httpMethod = "GET"
      request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
      
      URLSession.shared.dataTask(with: request) { (data, response, error) in
         guard let postData = data else { return }
         
         do {
            let post = try JSONDecoder().decode([Post].self, from: postData)
            DispatchQueue.global(qos: .utility).async {
               completion(post)
            }
         } catch {
            print(error)
         }
         
      }.resume()
   }
   
   //string param
   func getData(id: String, completion: @escaping (Post) -> ()){
      guard let url = URL(string: Constants().MAIN_URL + "post/" + id) else { return }
      
      var request = URLRequest(url: url)
      request.httpMethod = "GET"
      request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
      
      URLSession.shared.dataTask(with: request) { (data, response, error) in
         guard let postData = data else { return }
         do {
            let post = try JSONDecoder().decode(Post.self, from: postData)
            
            DispatchQueue.main.async {
               completion(post)
            }
            
         } catch {
            print(error)
         }
      }.resume()
   }
}
