//
//  ProfileData.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 10.05.2022.
//

import Foundation
import UIKit

class ProfileData {

    public let firstName: String
    public let lastName: String
    public let photo: UIImage
    public var nickname: String? = ""
    public var number: String? = ""

    init(firstName: String, lastName: String, photo: UIImage, number: String?, nickname: String?) {
        self.firstName = firstName
        self.lastName = lastName
        self.photo = photo
        self.number = number
        self.nickname = nickname
    }
}
