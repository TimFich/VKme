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

struct UserItems: Codable, Hashable {
    let id: Int
    let firstName, lastName: String
    let photo: String?
    let sex: Int?
    let screenName: String?
    let photo_100: String?
    var domain: String?
    let phoneNumber: String?

    enum CodingKeys: String, CodingKey {
        case id, photo_100, sex, domain
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_200_orig"
        case screenName = "screen_name"
        case phoneNumber = "mobile_phone"
    }
}

// MARK: - Response
struct FriendEntity: Codable {
    let count: Int
    let items: [FriendItem]
}

// MARK: - Item
struct FriendItem: Codable {
    let id: Int
    let firstName, lastName: String
    let photo100: String
    let deactivated: Deactivated?
    let online: Int
    let lastSeen: LastSeen?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo100 = "photo_100"
        case online
        case lastSeen = "last_seen"
        case deactivated
    }

    struct LastSeen: Codable {
        let platform, time: Int?
    }

    enum Deactivated: String, Codable {
        case banned = "banned"
        case deleted = "deleted"
    }
}
