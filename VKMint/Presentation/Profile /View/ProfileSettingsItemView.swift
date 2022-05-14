//
//  ProfileSettingsItemsView.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 14.05.2022.
//

import Foundation
import UIKit
import SnapKit

class ProfileSettingsItemView: UIView {
    
    //MARK: - UI
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    private lazy var imageOfArrow: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(systemName: "arrow.turn.up.right")
        return imageView
    }()
    
    init(title: String, image: UIImage) {
        super.init(frame: .zero)
        self.title.text = title
        self.imageView.image = image
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        
        self.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 25, height: 25))
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
        
        self.addSubview(title)
        title.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16)
            make.left.equalTo(imageView.snp.right).offset(10)
            make.right.equalToSuperview().inset(40)
        }
        
        self.addSubview(imageOfArrow)
        imageOfArrow.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 20, height: 20))
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10)
        }
    }
}
