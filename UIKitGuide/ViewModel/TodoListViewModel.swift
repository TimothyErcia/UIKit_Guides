//
//  TodoListViewModel.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/16/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import Foundation

struct TodoListViewModel {
   var list: Observable<[Lesson5CellViewModel]> = Observable([])
}

struct Lesson5CellViewModel {
   var createdAt: Date?
   var name: String?
   var hasStatus: Bool
}
