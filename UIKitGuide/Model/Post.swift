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
