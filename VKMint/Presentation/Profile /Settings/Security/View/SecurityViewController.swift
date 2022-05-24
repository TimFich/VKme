//
//  SecurityViewController.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 24.05.2022.
//

import UIKit
import LocalAuthentication

protocol SecurityViewInput: AnyObject {
    
}

protocol SecurityViewOutput: AnyObject {
    
}

class SecurityViewController: UIViewController {
    
    var presenter: SecurityPresenter!
    
    private var isUnlocked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        title = "Security"
        authenicate()
        view.backgroundColor = .systemBackground
    }
    
    func authenicate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            let textReason = "We need to access your face"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: textReason) { success, authError in DispatchQueue.main.async {
                if success {
                    self.isUnlocked = true
                    print("sabdaskbjkdbaskjdasjdbkasbjdasbdk")
                } else {
                    
                }
            }
            }
            
        } else {
            print("\(String(describing: error))")
        }
    }
}

//MARK: - SecurityViewInput
extension SecurityViewController: SecurityViewInput {
    
}
