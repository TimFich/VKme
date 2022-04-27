//
//  CDConversationClass+CoreDataProperties.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 27.04.2022.
//
//

import Foundation
import CoreData


extension CDConversationClass {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDConversationClass> {
        return NSFetchRequest<CDConversationClass>(entityName: "CDConversationClass")
    }

    @NSManaged public var isMarkedUnread: Bool
    @NSManaged public var unreadCount: Int64
    @NSManaged public var peer: CDPeer?
    @NSManaged public var chatSettings: CDChatSettings?

}

extension CDConversationClass : Identifiable {

}
