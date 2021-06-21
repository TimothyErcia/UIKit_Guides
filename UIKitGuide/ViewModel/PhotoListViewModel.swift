//
//  PhotoListViewModel.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/11/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import Foundation


public struct PhotoListViewModel {
   var list: Observable<[Lesson4ViewCellModel]> = Observable([])
}

struct Lesson4ViewCellModel {
   var imageView: String?
   var titleView: String
   var urlView: String?
}
