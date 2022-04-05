//
//  AuthViewController.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 20.01.2022.
//

import UIKit
import SwiftyVK

class AuthViewController: UIViewController {
    
    //MARK: - Properties
    let authModel = AuthModel()
    private let navigator = AuthorisationNavigator()
    
    //MARK: - UI
    @IBOutlet weak var loginButton: UIButton!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigator.parentViewController = self
    }
    
    @IBAction func logInButtonPressed(_ sender: Any) {
        authModel.authorize(completion: { [weak self] in
            DispatchQueue.main.async {
                
                self?.performSegue(withIdentifier: "enter", sender: nil)
            }
        }, onError: {
        })
        segueIfAuthorised()
    }
    
    //MARK: - Private functions
    private func segueIfAuthorised() {
        if VKDelegate.isAuthorised() {
            self.performSegue(withIdentifier: "enter", sender: nil)
        }
    }
}

extension AuthViewController: AuthorisationViewProtocol {
    func enterButtonPressed() {
        navigator.segueToMessages()
    }
}
