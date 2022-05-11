//
//  ContactsTableViewCell.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 28.04.2022.
//

import UIKit
import SnapKit

class ContactsTableViewCell: UITableViewCell {
    
    //MARK: - Private properties
    private let dateConverter: DateConverter = DateConverterImpl()

    //MARK: - UI
    var lastSeenLabel = UILabel()
    var onlineStatus = UIImageView()
    var nameOfUserLabel = UILabel()
    var avatarOfUser = UIImageView()
    
    func configure(name: String, avatar: UIImage, lastSeen: Int, platform: Int, isOnline: Bool) {
        avatarOfUser.image = avatar
        avatarOfUser.clipsToBounds = true
        avatarOfUser.layer.cornerRadius = avatarOfUser.frame.height / 2
        nameOfUserLabel.text = name
        if isOnline {
            onlineStatus.isHidden = false
            let platformImage = PlatformImageGenerator().generateImage(platform: platform)
            onlineStatus.image = platformImage
        } else {
            onlineStatus.isHidden = true
        }
        lastSeenLabel.text = dateConverter.convert(lastSeen)
        setUpUI()
    }
    
    private func setUpUI() {
        contentView.addSubview(avatarOfUser)
        avatarOfUser.snp.makeConstraints({ make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(5)
            make.size.equalTo(CGSize(width: 50, height: 50))
        })
        
        contentView.addSubview(onlineStatus)
        onlineStatus.snp.makeConstraints({ make in
            make.right.equalTo(avatarOfUser).inset(0)
            make.bottom.equalTo(avatarOfUser).inset(0)
            make.size.equalTo(CGSize(width: 18, height: 20))
        })
        
        contentView.addSubview(nameOfUserLabel)
        nameOfUserLabel.snp.makeConstraints({ make in
            make.left.equalTo(avatarOfUser.snp.right).offset(10)
            make.top.equalToSuperview().offset(5)
            make.right.equalToSuperview().inset(10)
        })
        
        contentView.addSubview(lastSeenLabel)
        lastSeenLabel.snp.makeConstraints({ make in
            make.left.equalTo(avatarOfUser.snp.right).offset(10)
            make.top.equalTo(nameOfUserLabel.snp.bottom).offset(10)
            make.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        })
    }
}
