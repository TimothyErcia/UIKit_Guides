//
//  APICollection.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/12/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import Foundation
import Combine

enum APICollectionError: String, Error {
   case responseError = "Response Error: "
   case requestError = "Can't connect to the server, Please try again"
   case urlError = "URL not found"
}

public class API_PostCollection {
   
   static let shared = API_PostCollection()
   
   func getAllData() -> Future<[Post], APICollectionError> {
      return Future { promise in
         guard let url = URL(string: Constants.shared.MAIN_URL + "postss") else {
            promise(.failure(.urlError))
            return
         }
         
         var request = URLRequest(url: url)
         request.httpMethod = "GET"
         request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
         
         URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let postData = data else {
               promise(.failure(.responseError))
               return
            }
            
            guard let responseStatus = response as? HTTPURLResponse, responseStatus.statusCode == 200 else {
               promise(.failure(.responseError))
               return
            }
            
            do {
               let post = try JSONDecoder().decode([Post].self, from: postData)
               promise(.success(post))
            } catch {
               promise(.failure(.requestError))
            }
            
         }.resume()
      }
   }
   
   //string param
   func getData(param: String) -> Future<Post, APICollectionError> {
      return Future { promise in
         guard let url = URL(string: Constants().MAIN_URL + "posts/\(param)") else {
            promise(.failure(.urlError))
            return
         }
         
         var request = URLRequest(url: url)
         request.httpMethod = "GET"
         request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
         
         URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let postData = data else {
               promise(.failure(.responseError))
               return
            }
            
            guard let responseStatus = response as? HTTPURLResponse, responseStatus.statusCode == 200 else {
               promise(.failure(.responseError))
               return
            }
            
            do {
               let post = try JSONDecoder().decode(Post.self, from: postData)
               promise(.success(post))
            } catch {
               promise(.failure(.requestError))
            }
            
         }.resume()
      }
   }
   
   func addData(post: Post) -> Future<String, APICollectionError> {
      return Future { promise in
         guard let url = URL(string: Constants().MAIN_URL + "posts") else {
            promise(.failure(.urlError))
            return
         }
         
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
         
         URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let postData = data else {
               promise(.failure(.responseError))
               return
            }
            
            guard let responseStatus = response as? HTTPURLResponse, responseStatus.statusCode == 200 else {
               promise(.failure(.responseError))
               return
            }
            
            do {
               let post = try JSONDecoder().decode(String.self, from: postData)
               promise(.success(post))
            } catch {
               promise(.failure(.requestError))
            }
            
         }.resume()
      }
   }
   
}

class API_PhotoCollection {
   
   static let shared = API_PhotoCollection()
   
   func getAllData() -> Future<[Photos], APICollectionError> {
      return Future { promise in
         guard let url = URL(string: Constants().MAIN_URL + "photos") else {
            promise(.failure(.urlError))
            return
         }
         
         var request = URLRequest(url: url)
         request.httpMethod = "GET"
         request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
         
         URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let photoData = data else {
               promise(.failure(.responseError))
               return
            }
            
            guard let responseStatus = response as? HTTPURLResponse, responseStatus.statusCode == 200 else {
               promise(.failure(.responseError))
               return
            }
            
            do {
               let photo = try JSONDecoder().decode([Photos].self, from: photoData)
               promise(.success(photo))
            } catch {
               promise(.failure(.requestError))
               return
            }
            
         }.resume()
      }
   }
}
