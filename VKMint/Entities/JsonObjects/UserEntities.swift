//
//  UserEntities.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 16.03.2022.
//

import Foundation

// MARK: - UserEntities
struct UserEntities: Codable {
    let count: Int
    let items: [UserItems]
}

struct UserItems: Codable {
    let id: Int
    let firstName, lastName: String
    let photo: String?
    let sex: Int?
    let screenName: String?
    let photo_100: String?
    let onlineInfo: OnlineInfo?
    
    enum CodingKeys: String, CodingKey {
        case id, photo_100, sex
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_200_orig"
        case screenName = "screen_name"
        case onlineInfo = "online_info"
    }
}

struct OnlineInfo: Codable {
    let lastSeen: Int?
    let isOnline: Bool?
    let isMobile: Bool?
    
    enum CodingKeys: String, CodingKey {
        case lastSeen = "last_seen"
        case isOnline = "is_online"
        case isMobile = "is_mobile"
    }
}
