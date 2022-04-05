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
        logo.image = UIImage(named: "mainLogo")
         backgroundColor = .white
        addSubview(logo)
        logo.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 300, height: 300))
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        addSubview(mainLabel)
         mainLabel.tintColor = .black
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(logo).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(20)
            make.right.equalToSuperview().inset(20)
            make.left.equalToSuperview().offset(20)
        }
        addSubview(sigInButton)
        sigInButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    @objc
    func registration() {
        delegate.enterButtonPressed()
    }
}
