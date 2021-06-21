//
//  TodoItem+CoreDataProperties.swift
//  
//
//  Created by Timothy Ercia on 6/18/21.
//
//

import Foundation
import CoreData


extension TodoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoItem> {
        return NSFetchRequest<TodoItem>(entityName: "TodoItem")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var name: String?
    @NSManaged public var hasStatus: Bool

}
