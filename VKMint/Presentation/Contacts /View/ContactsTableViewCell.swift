//
//  ContactsTableViewCell.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 28.04.2022.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarOfUser: UIImageView!
    @IBOutlet weak var nameOfUser: UILabel!
    
    func configure(name: String, avatar: UIImage) {
        avatarOfUser.image = avatar
        nameOfUser.text = name
    }
}
