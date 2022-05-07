//
//  CDChatSettings+CoreDataProperties.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 27.04.2022.
//
//

import Foundation
import CoreData


extension CDChatSettings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDChatSettings> {
        return NSFetchRequest<CDChatSettings>(entityName: "CDChatSettings")
    }

    @NSManaged public var ownerID: Int64
    @NSManaged public var membersCount: Int64
    @NSManaged public var title: String?
    @NSManaged public var photo: NSData?

}

extension CDChatSettings : Identifiable {

}
