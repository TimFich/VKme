//
//  CDItems+CoreDataProperties.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 27.04.2022.
//
//

import Foundation
import CoreData


extension CDItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDItems> {
        return NSFetchRequest<CDItems>(entityName: "CDItems")
    }

    @NSManaged public var lastMessage: CDLastMessage?
    @NSManaged public var conversation: CDConversationClass

}

extension CDItems : Identifiable {

}
