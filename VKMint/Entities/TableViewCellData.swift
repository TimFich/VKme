//
//  TableViewCellData.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 16.03.2022.
//

import Foundation
import UIKit

class TableViewCellData {

    public let title: String
    public var avatarOfChat: UIImage
    public var lastMessage: String
    public let type: TypeEnum
    public let peerId: Int
    public var unreadCount = 0

    init(peerId: Int, title: String, avatarOfChat: UIImage, lastMessage: String, type: TypeEnum, unreadCount: Int) {
        self.peerId = peerId
        self.title = title
        self.avatarOfChat = avatarOfChat
        self.lastMessage = lastMessage
        self.type = type
        self.unreadCount = unreadCount
    }
}
