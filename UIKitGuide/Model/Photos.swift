//
//  Photos.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/6/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import Foundation

struct Photos: Codable, Identifiable {
   var id: Int
   var albumId: Int
   var title: String
   var thumbnailUrl: String
}
