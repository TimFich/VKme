//
//  MessagesableViewCell.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 26.01.2022.
//

import UIKit
import SnapKit

class MessagesTableViewCell: UITableViewCell {
    
    //MARK: - UI
    var convImage = UIImageView()
    var titleLabel = UILabel()
    var lastMessageLabel = UILabel()
    var unreadCountLabel = UILabel()
    
    // MARK: - Public functions
    func configure(cellData: MessageTableViewCellData) {
        self.convImage.image = cellData.avatarOfChat
        self.titleLabel.text = cellData.title
        self.lastMessageLabel.text = cellData.lastMessage
        if cellData.unreadCount != 0 {
            unreadCountLabel.isHidden = false
            unreadCountLabel.backgroundColor = .systemBlue
            unreadCountLabel.text = cellData.unreadCount.description
        } else {
            unreadCountLabel.isHidden = true
        }
        setUpUI()
    }

    private func setUpUI() {
        
        contentView.addSubview(convImage)
        convImage.layer.cornerRadius = 30
        convImage.clipsToBounds = true
        convImage.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().inset(10)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(convImage.snp.right).offset(10)
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().inset(50)
        }
        
        contentView.addSubview(unreadCountLabel)
        unreadCountLabel.textAlignment = .center
        unreadCountLabel.layer.cornerRadius = 10
        unreadCountLabel.clipsToBounds = true
        unreadCountLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 20, height: 20))
            make.right.equalToSuperview().inset(5)
            make.left.equalTo(titleLabel.snp.right).offset(10)
        }
        
        contentView.addSubview(lastMessageLabel)
        lastMessageLabel.snp.makeConstraints { make in
            make.left.equalTo(convImage.snp.right).offset(10)
            make.right.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().inset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
    }
}
