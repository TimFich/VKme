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
    var convImage: UIImageView!
    var titleLabel: UILabel!
    var lastMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Public functions
    func configure(cellData: TableViewCellData) {
        self.convImage.layer.cornerRadius = self.convImage.frame.height / 2
        self.convImage.image = cellData.avatarOfChat
        self.titleLabel.text = cellData.title
        self.lastMessageLabel.text = cellData.lastMessage
        setUpUI()
    }
    
    private func setUpUI(){
        contentView.addSubview(convImage)
        convImage.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(convImage.snp.right).inset(10)
            make.top.equalToSuperview().inset(10)
            make.right.equalToSuperview().offset(10)
        }
        
        contentView.addSubview(lastMessageLabel)
        lastMessageLabel.snp.makeConstraints { make in
            make.left.equalTo(convImage.snp.right).inset(10)
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(10)
            make.top.equalTo(titleLabel.snp.bottom).inset(5)
        }
    }
}


