//
//  ContactsTableViewCellData.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 09.05.2022.
//

import Foundation
import UIKit

class ContactsTableViewCellData {
    
    let id: Int
    let firstName: String
    let lastName: String
    var photo: UIImage
    let lastSeen: Int
    let isOnline: Bool
    let platform: Int

    init(id: Int, firstName: String, lastName: String, photo: UIImage, lastSeen: Int, isOnline: Bool, platform: Int) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.photo = photo
        self.lastSeen = lastSeen
        self.isOnline = isOnline
        self.platform = platform
    }
}
