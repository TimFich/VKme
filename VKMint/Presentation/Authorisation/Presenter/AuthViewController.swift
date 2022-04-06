//
//  AuthViewController.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 20.01.2022.
//

import UIKit
import SwiftyVK
import SnapKit

class AuthViewController: UIViewController {
    
    //MARK: - Properties
    let authModel = AuthModel()
    private let navigator = AuthorisationNavigator()
    
    private let mainView = AuthorisationView()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        navigator.parentViewController = self
    }
    
    func setUpView() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
//    @IBAction func logInButtonPressed(_ sender: Any) {
//        authModel.authorize(completion: { [weak self] in
//            DispatchQueue.main.async {
//
//                self?.performSegue(withIdentifier: "enter", sender: nil)
//            }
//        }, onError: {
//        })
//        segueIfAuthorised()
//    }
//
//    //MARK: - Private functions
//    private func segueIfAuthorised() {
//        if VKDelegate.isAuthorised() {
//            self.performSegue(withIdentifier: "enter", sender: nil)
//        }
//    }
}

extension AuthViewController: AuthorisationViewProtocol {
    func enterButtonPressed() {
        navigator.segueToMessages()
    }
}
