//
//  CDConversations+CoreDataProperties.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 27.04.2022.
//
//

import Foundation
import CoreData


extension CDConversations {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDConversations> {
        return NSFetchRequest<CDConversations>(entityName: "CDConversations")
    }

    @NSManaged public var unreadCount: Int64
    @NSManaged public var count: Int64
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for items
extension CDConversations {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: CDItems)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: CDItems)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

extension CDConversations : Identifiable {

}
