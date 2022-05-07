//
//  CDUserItems+CoreDataProperties.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 03.05.2022.
//

import Foundation
import CoreData

extension CDUserItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUserItems> {
        return NSFetchRequest<CDUserItems>(entityName: "CDUserItems")
    }

    @NSManaged public var id: Int64
    @NSManaged public var firstName: String
    @NSManaged public var lastName: String
    @NSManaged public var photo: NSData
}

extension CDUserItems: Identifiable {

}
