//
//  ChatUser.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 29.05.2022.
//

import Foundation
import MessageKit

struct ChatUser: SenderType {
    var senderId: String
    
    var displayName: String
}
