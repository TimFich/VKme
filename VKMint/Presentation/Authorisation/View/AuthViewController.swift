//
//  AuthViewController.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 20.01.2022.
//

import UIKit
import SwiftyVK
import SnapKit

protocol AuthViewOutput: AnyObject {
    func signInButtonPressed()
}

class AuthViewController: UIViewController {
    
    //MARK: - Properties
    var presenter: AuthViewOutput!
    
    //MARK: - UI
    let logo = UIImageView()
    let mainLabel = UILabel()
    let descriptionLabel = UILabel()
    let sigInButton: UIButton = {
        let button = UIButton()
        button.addTarget(nil, action: #selector(registration), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    //MARK: - Make constraints
     func setUpUI() {
         view.addSubview(logo)
         logo.image = UIImage(named: "vk_logo")
         view.backgroundColor = .white
         logo.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 300, height: 300))
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
         view.addSubview(mainLabel)
         mainLabel.tintColor = .black
         mainLabel.textAlignment = .center
         mainLabel.text = "VK me!!!"
         
         mainLabel.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
         view.addSubview(descriptionLabel)
         descriptionLabel.tintColor = .black
         descriptionLabel.textAlignment = .center
         descriptionLabel.text = "Test"
         descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(20)
            make.right.equalToSuperview().inset(20)
            make.left.equalToSuperview().inset(20)
        }
         view.addSubview(sigInButton)
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
        presenter.signInButtonPressed()
    }
}
