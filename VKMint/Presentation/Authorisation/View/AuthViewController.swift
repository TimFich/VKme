//
//  AuthViewController.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 20.01.2022.
//

import UIKit
import SnapKit

protocol AuthViewOutput: AnyObject {
    func signInButtonPressed()
}

class AuthViewController: UIViewController {

    // MARK: - Properties
    var presenter: AuthViewOutput!

    // MARK: - UI
    let logo = UIImageView()
    let sigInButton: UIButton = {
        let button = UIButton()
        button.addTarget(nil, action: #selector(registration), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setUpUI()
    }

    // MARK: - Make constraints
     func setUpUI() {
         view.addSubview(logo)
         logo.image = UIImage(named: "VK_Logo")
         logo.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 300, height: 300))
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }

         view.addSubview(sigInButton)
         sigInButton.backgroundColor = .systemBlue
         sigInButton.layer.cornerRadius = 10
         sigInButton.titleLabel?.tintColor = .black
         sigInButton.setTitle("Sig In and Registration", for: .normal)
         sigInButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(50)
        }
    }

    // MARK: - Actions
    @objc
    func registration() {
        presenter.signInButtonPressed()
    }
}
