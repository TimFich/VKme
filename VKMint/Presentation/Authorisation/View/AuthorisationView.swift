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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Make constraints
     func setUpUI() {
        logo.image = UIImage(named: "vk_logo")
         backgroundColor = .white
        addSubview(logo)
        logo.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 300, height: 300))
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        addSubview(mainLabel)
         mainLabel.tintColor = .black
         mainLabel.textAlignment = .center
         mainLabel.text = "VK me!!!"
         
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        addSubview(descriptionLabel)
         descriptionLabel.tintColor = .black
         descriptionLabel.textAlignment = .center
         descriptionLabel.text = "Test"
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(20)
            make.right.equalToSuperview().inset(20)
            make.left.equalToSuperview().inset(20)
        }
        addSubview(sigInButton)
         sigInButton.backgroundColor = .systemBlue
         sigInButton.layer.cornerRadius = 10
         sigInButton.titleLabel?.tintColor = .black
         sigInButton.setTitle("Sig In", for: .normal)
        sigInButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(50)
        }
    }
    
    @objc
    func registration() {
        delegate.enterButtonPressed()
    }
}
