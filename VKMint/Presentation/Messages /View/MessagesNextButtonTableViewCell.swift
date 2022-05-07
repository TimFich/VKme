//
//  MessagesNextButtonTableViewCell.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 05.05.2022.
//

import UIKit

protocol MessagesNextButtonCellOutputProtocol: AnyObject {
    func nextPressed()
}

class MessagesNextButtonTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    weak var output: MessagesNextButtonCellOutputProtocol!
    
    //MARK: - UI
    let nextButton: UIButton = {
        let button = UIButton()
        button.addTarget(nil, action: #selector(nextButtonPressed), for: .touchUpInside)
        return button
    }()
    
    @objc func nextButtonPressed() {
        output.nextPressed()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
