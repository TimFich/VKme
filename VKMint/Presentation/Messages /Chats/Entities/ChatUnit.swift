//
//  ChatUnit.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 29.05.2022.
//

import Foundation
import MessageKit

struct ChatUnit: MessageType {

    var sender: SenderType

    var messageId: String

    var sentDate: Date

    var kind: MessageKind
}
