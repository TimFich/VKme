//
//  AuthorisationView.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 04.04.2022.
//

import UIKit
import SnapKit

class AuthorisationView: UIView {
    
    //MARK: - Properties
    
    weak var delegate: AuthorisationViewProtocol!
    
    //MARK: - UI
    let logo = UIImageView()
    let mainLabel = UILabel()
    let descriptionLabel = UILabel()
    let sigInButton: UIButton = {
        let button = UIButton()
        button.addTarget(nil, action: #selector(registration), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Make constraints
    override func draw(_ rect: CGRect) {
        logo.image = UIImage(named: "mainLogo")
        self.addSubview(logo)
        logo.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 300, height: 300))
            make.centerY.equalTo(self)
            make.left.equalTo(self.snp.left).offset(70)
        }
        self.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(logo).offset(20)
            make.left.right.equalToSuperview().offset(20)
        }
        self.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel).offset(20)
            make.right.left.equalToSuperview().offset(20)
        }
        self.addSubview(sigInButton)
        sigInButton.snp.makeConstraints { make in
            make.right.left.bottom.equalToSuperview().offset(20)
        }
    }
    
    @objc
    func registration() {
        delegate.enterButtonPressed()
    }
}
