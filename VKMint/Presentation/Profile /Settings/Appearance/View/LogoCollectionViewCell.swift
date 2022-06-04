//
//  LogoCollectionViewCell.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 23.05.2022.
//

import UIKit

class LogoCollectionViewCell: UICollectionViewCell {

    private lazy var image: UIImageView = {
        let imageView = UIImageView(image: nil)
        return imageView
    }()

    func configure(index: Int) {

        configureUI()

        switch index {

        case 0:
            image.image = UIImage(named: "VK_Logo")
        case 1:
            image.image = UIImage(named: "second_Logo")
        case 2:
            image.image = UIImage(named: "third_Logo")
        case 3:
            image.image = UIImage(named: "fourth_Logo")
        case 4:
            image.image = UIImage(named: "fifth_Logo")
        default:
            image.image = UIImage(named: "VK_Logo")
        }
    }

    private func configureUI() {
        contentView.addSubview(image)
        image.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
    }
}
