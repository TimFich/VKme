//
//  CDPeer+CoreDataProperties.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 27.04.2022.
//
//

import Foundation
import CoreData

extension CDPeer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPeer> {
        return NSFetchRequest<CDPeer>(entityName: "CDPeer")
    }

    @NSManaged public var id: Int64
    @NSManaged public var type: String

}

extension CDPeer : Identifiable {

}
