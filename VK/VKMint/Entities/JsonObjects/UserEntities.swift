//
//  UserEntities.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 16.03.2022.
//

import Foundation

// MARK: - UserEntities
struct UserEntities: Codable {
    var id: Int
    var firstName, lastName: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
