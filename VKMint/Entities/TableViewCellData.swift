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
    public let lastMessage: String
    public let type: TypeEnum
    public let peerId: Int
    
    init(peerId: Int, title: String, avatarOfChat: UIImage, lastMessage: String, type: TypeEnum) {
        self.peerId = peerId
        self.title = title
        self.avatarOfChat = avatarOfChat
        self.lastMessage = lastMessage
        self.type = type
    }
}
