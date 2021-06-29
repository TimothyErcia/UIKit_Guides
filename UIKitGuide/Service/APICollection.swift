//
//  APICollection.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/12/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import Foundation

enum APICollectionError: String, Error {
   case responseError = "Response error"
   case requestError
   case urlError = "URL not found"
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
   
   private func execute(_ request: URLRequest, _ completion: @escaping (Post) -> ()){
      URLSession.shared.dataTask(with: request) { (data, response, error) in
         guard let postData = data else { return }
         
         do {
            let post = try JSONDecoder().decode(Post.self, from: postData)
            completion(post)
         } catch {
            print(error)
         }
         
      }.resume()
   }
   
   private func executeList(_ request: URLRequest, _ completion: @escaping ([Post]) -> ()){
      URLSession.shared.dataTask(with: request) { (data, response, error) in
         guard let postData = data else { return }
         
         do {
            let post = try JSONDecoder().decode([Post].self, from: postData)
            completion(post)
         } catch {
            print(error)
         }
         
      }.resume()
   }
   
}

class API_PhotoCollection {
   func getAllData(completion: @escaping (Result<[Photos], APICollectionError>) -> ()){
      guard let url = URL(string: Constants().MAIN_URL + "photoss") else {
         completion(.failure(.urlError))
         return
      }
      
      var request = URLRequest(url: url)
      request.httpMethod = "GET"
      request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
      
      URLSession.shared.dataTask(with: request) { (data, response, error) in
         guard let photoData = data else {
            completion(.failure(.responseError))
            return
         }
         
         guard let responseStatus = response as? HTTPURLResponse, responseStatus.statusCode == 200 else {
            completion(.failure(.responseError))
            return
         }
         
         do {
            let photo = try JSONDecoder().decode([Photos].self, from: photoData)
            completion(.success(photo))
         } catch {
            completion(.failure(.responseError))
            return
         }
         
      }.resume()
   }
}
