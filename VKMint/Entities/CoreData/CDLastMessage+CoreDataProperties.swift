//
//  CDLastMessage+CoreDataProperties.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 27.04.2022.
//
//

import Foundation
import CoreData


extension CDLastMessage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDLastMessage> {
        return NSFetchRequest<CDLastMessage>(entityName: "CDLastMessage")
    }

    @NSManaged public var peerID: Int64
    @NSManaged public var id: Int64
    @NSManaged public var date: Date
    @NSManaged public var text: String?
}

extension CDLastMessage : Identifiable {

}
