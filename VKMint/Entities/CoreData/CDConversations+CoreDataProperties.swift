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
    @NSManaged public var items: NSOrderedSet
    @NSManaged public var profiles: NSOrderedSet

}

// MARK: Generated accessors for items
extension CDConversations {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: CDItems)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: CDItems)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: Set<CDItems>)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: Set<CDItems>)
    
    @objc(addProfilesObject:)
    @NSManaged public func addToProfiles(_ value: CDUserItems)

    @objc(removeProfilesObject:)
    @NSManaged public func removeFromProfiles(_ value: CDUserItems)

    @objc(addProfiles:)
    @NSManaged public func addToProfiles(_ values: Set<CDUserItems>)

    @objc(removeProfiles:)
    @NSManaged public func removeFromProfiles(_ values: Set<CDUserItems>)

}

extension CDConversations : Identifiable {

}
