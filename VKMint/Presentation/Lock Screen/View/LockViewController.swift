//
//  LockViewController.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 25.05.2022.
//

import UIKit
import SmileLock
import SnapKit


protocol LockViewInput: AnyObject {
    
}

protocol LockViewOutput: AnyObject {
    func needToPerformNewScreen(parentViewController: UINavigationController)
}


class LockViewController: UIViewController {
    
    //MARK: - Properties
    var presenter: LockPresenter!
    var passwordContainerView: PasswordContainerView!
    let kPasswordDigit = 6
    private var password = ""
    private let keyChainManager = KeychainManager()
    
    //MARK: - UI
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        return stackView
    }()
    
    //MARK: - View life cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        password = keyChainManager.getChain()
        title = "Lock Screen"
        view.backgroundColor = .systemBackground
        setUpUI()
    }
    
    //MARK: - Configure UI
    private func setUpUI() {
        view.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        passwordContainerView = PasswordContainerView.create(in: mainStackView, digit: kPasswordDigit)
        passwordContainerView.delegate = self
        passwordContainerView.deleteButton.setTitle("", for: .normal)
        passwordContainerView.deleteButton.setImage(UIImage(systemName: "delete.left.fill"), for: .normal)
        passwordContainerView.tintColor = .systemGray
        passwordContainerView.highlightedColor = .blue
    }
}

//MARK: - PasswordInputCompleteProtocol
extension LockViewController: PasswordInputCompleteProtocol {
    func passwordInputComplete(_ passwordContainerView: PasswordContainerView, input: String) {
        if password != "" {
            if validation(input) {
                validationSuccess()
            } else {
                validationFail()
            }
        } else {
            keyChainManager.saveChain(password: input)
            validationSuccess()
        }
    }
    
    func touchAuthenticationComplete(_ passwordContainerView: PasswordContainerView, success: Bool, error: Error?) {
        if success {
            self.validationSuccess()
        } else {
            passwordContainerView.clearInput()
        }
    }
}

private extension LockViewController {
    func validation(_ input: String) -> Bool {
        return input == self.password
    }
    
    func validationSuccess() {
        print("*️⃣ success!")
        presenter.needToPerformNewScreen(parentViewController: navigationController!)
    }
    
    func validationFail() {
        print("*️⃣ failure!")
        passwordContainerView.wrongPassword()
    }
}

//MARK: - LockViewInput
extension LockViewController: LockViewInput {
    
}
