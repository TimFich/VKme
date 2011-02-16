//
//  ProfileSettingsItemsView.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 14.05.2022.
//

import Foundation
import UIKit
import SnapKit

protocol ProfileSettingsItemOutput: AnyObject {
    func buttonTaped(flag: Int)
}

class ProfileSettingsItemView: UIView {

    // MARK: - Private properties

    private var flagOfChange = true
    private var output: ProfileSettingsItemOutput

    // MARK: - UI

    fileprivate lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var title: UIButton = {
        let button = UIButton(frame: .zero)
        button.addTarget(nil, action: #selector(touchItem), for: .touchUpInside)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(UIColor.systemGray, for: .normal)
        return button
    }()

    private lazy var imageOfArrow: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(systemName: "arrow.turn.up.right")
        return imageView
    }()

    init(title: String, image: UIImage, output: ProfileSettingsItemOutput) {
        self.output = output
        super.init(frame: .zero)
        self.title.setTitle(title, for: .normal)
        self.imageView.image = image
        setUpUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - configure UI
    
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
//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        super.traitCollectionDidChange(previousTraitCollection)
//        
//        if traintCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
//            title.setTitleColor(.black, for: .normal)
//        }
//    }
//
    // MARK: - Action
    
    @objc
    func touchItem() {
        if title.currentTitle == "Appearance" {
            output.buttonTaped(flag: 1)
        } else if title.currentTitle == "Security" {
            output.buttonTaped(flag: 2)
        } else {
            output.buttonTaped(flag: 3)
        }
    }
}
