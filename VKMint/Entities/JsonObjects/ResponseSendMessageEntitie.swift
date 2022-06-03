//
//  ResponseSendMessageEntitie.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 03.06.2022.
//

import Foundation

struct ResponseOfMessage: Codable {
    let messageId: Int
    
    enum CodingKeys: String, CodingKey {
        case messageId = "response"
    }
}
