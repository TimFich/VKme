//
//  MessagesableViewCell.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 26.01.2022.
//

import UIKit

class MessagesTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var convImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    
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
    }
}
