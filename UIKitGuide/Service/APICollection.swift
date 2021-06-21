//
//  APICollection.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/12/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import Foundation

enum APICollectionError: Error {
   case responseError
   case requestError
   case urlError
}

class API_PostCollection {
   func getAllData(completion: @escaping ([Post]) -> ()){
      guard let url = URL(string: Constants().MAIN_URL + "posts") else { return }
      
      var request = URLRequest(url: url)
      request.httpMethod = "GET"
      request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
      
      executeList(request, completion)
   }
   
   //string param
   func getData(param: String, completion: @escaping (Post) -> ()){
      guard let url = URL(string: Constants().MAIN_URL + "posts/\(param)") else { return }
      
      var request = URLRequest(url: url)
      request.httpMethod = "GET"
      request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
      
      execute(request, completion)
   }
   
   func addData(post: Post, completion: @escaping (Post) -> ()){
      guard let url = URL(string: Constants().MAIN_URL + "posts") else { return }
      
      let body: [String: Any] = [
         "id": post.id,
         "userId": post.userId,
         "title": post.title,
         "body": post.body
      ]
      
      let bodyValue = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
      
      var request = URLRequest(url: url)
      request.httpBody = bodyValue
      request.httpMethod = "POST"
      request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
      
      execute(request, completion)
   }
   
   func execute(_ request: URLRequest, _ completion: @escaping (Post) -> ()){
      URLSession.shared.dataTask(with: request) { (data, response, error) in
         guard let postData = data else { return }
         
         do {
            let post = try JSONDecoder().decode(Post.self, from: postData)
            DispatchQueue.global(qos: .userInitiated).async {
               completion(post)
            }
         } catch {
            print(error)
         }
         
      }.resume()
   }
   
   func executeList(_ request: URLRequest, _ completion: @escaping ([Post]) -> ()){
      URLSession.shared.dataTask(with: request) { (data, response, error) in
         guard let postData = data else { return }
         
         do {
            let post = try JSONDecoder().decode([Post].self, from: postData)
            DispatchQueue.global(qos: .userInitiated).async {
               completion(post)
            }
         } catch {
            print(error)
         }
         
      }.resume()
   }
   
}

class API_PhotoCollection {
   func getAllData(completion: @escaping ([Photos]?, Error?) -> ()){
      guard let url = URL(string: Constants().MAIN_URL + "photos") else {
         completion(nil, APICollectionError.urlError)
         return
      }
      
      var request = URLRequest(url: url)
      request.httpMethod = "GET"
      request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
      
      URLSession.shared.dataTask(with: request) { (data, response, error) in
         guard let photoData = data else {
            completion(nil, APICollectionError.requestError)
            return
         }
         
         guard let responseStatus = response as? HTTPURLResponse, responseStatus.statusCode == 200 else {
            completion(nil, APICollectionError.responseError)
            return
         }
         
         do {
            let photo = try JSONDecoder().decode([Photos].self, from: photoData)
            DispatchQueue.global(qos: .utility).async {
               completion(photo, nil)
            }
         } catch {
            completion(nil, APICollectionError.responseError)
            return
         }
         
      }.resume()
   }
}
