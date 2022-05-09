//
//  ContactsTableViewCellConverter.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 09.05.2022.
//

import Foundation
import UIKit

class ContactsTableViewCellConverter {
    
    func convertToCellData(contacts: FriendEntity, completion: @escaping ([ContactsTableViewCellData]) -> Void) {
        let imageDownloader = ImageDownloader()
        let helper = EscapingClosureHelper<ContactsTableViewCellData>(count: contacts.items.count)
        let contacts = contacts.items
        for contact in contacts {
            if contact.deactivated != nil {
                helper.photosCount -= 1
                continue
            }
            var avatar = UIImage(named: "VK_Logo")!
            let isOnline = contact.online == 1 ? true : false
            let cellData = ContactsTableViewCellData(
                id: contact.id,
                firstName: contact.firstName,
                lastName: contact.lastName,
                photo: avatar,
                lastSeen: contact.lastSeen!.time,
                isOnline: isOnline,
                platform: contact.lastSeen!.platform
            )
            helper.result.append(cellData)
            imageDownloader.downloadImage(urlOfPhoto: contact.photo100, completion: { image in
                cellData.photo = image
                helper.increase()
                if helper.isEnough() {
                    completion(helper.result)
                }
            })
        }
    }
    
    func convertToCellData(contacts: [CDContacts]) -> [ContactsTableViewCellData] {
        var result: [ContactsTableViewCellData] = []
        for contact in contacts {
            let data = Data(referencing: contact.photo)
            let cellData = ContactsTableViewCellData(
                id: Int(contact.id),
                firstName: contact.firstName,
                lastName: contact.lastName,
                photo: UIImage(data: data)!,
                lastSeen: Int(contact.lastSeen),
                isOnline: contact.isOnline,
                platform: Int(contact.platform)
            )
            result.append(cellData)
        }
        return result
    }
}
