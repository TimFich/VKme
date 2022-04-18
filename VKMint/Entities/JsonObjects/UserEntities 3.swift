//
//  UserEntities.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 16.03.2022.
//

import Foundation

// MARK: - UserEntities
struct UserEntities: Codable, Equatable {
    let id: Int
    let firstName, lastName: String
    let photo: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_200"
    }
    
    static func == (l: UserEntities, r: UserEntities) -> Bool {
        return l.id == r.id
    }
}
