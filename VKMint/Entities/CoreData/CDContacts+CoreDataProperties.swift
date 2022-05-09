//
//  CDContacts+CoreDataProperties.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 09.05.2022.
//

import Foundation
import CoreData

extension CDContacts {
        
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDContacts> {
        return NSFetchRequest<CDContacts>(entityName: "CDContacts")
    }

    @NSManaged public var id: Int64
    @NSManaged public var firstName: String
    @NSManaged public var lastName: String
    @NSManaged public var photo: NSData
    @NSManaged public var lastSeen: Int64
    @NSManaged public var isOnline: Bool
    @NSManaged public var platform: Int64
}

extension CDContacts: Identifiable {
    
}
