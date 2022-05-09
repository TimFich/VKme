//
//  MessagesableViewCell.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 26.01.2022.
//

import UIKit
import SnapKit

class MessagesTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    var convImage = UIImageView()
    var titleLabel = UILabel()
    var lastMessageLabel = UILabel()
    var unreadCountLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Public functions
    func configure(cellData: TableViewCellData) {
        self.convImage.image = cellData.avatarOfChat
        convImage.layer.cornerRadius = 10
        self.titleLabel.text = cellData.title
        self.lastMessageLabel.text = cellData.lastMessage
        if cellData.unreadCount != 0 {
            unreadCountLabel.text = cellData.unreadCount.description
        }
        setUpUI()
    }
    
    private func setUpUI(){
        contentView.addSubview(unreadCountLabel)
        unreadCountLabel.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
        contentView.addSubview(convImage)
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
            make.right.equalToSuperview().offset(10)
        }
        
        contentView.addSubview(lastMessageLabel)
        lastMessageLabel.snp.makeConstraints { make in
            make.left.equalTo(convImage.snp.right).offset(10)
            make.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
    }
}
