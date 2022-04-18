//
//  AuthorisationNavigator.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 04.04.2022.
//

import Foundation
import UIKit

class AuthorisationNavigator {
    
    private let builder = MessagesModuleBuilder()
    weak var parentViewController: UIViewController!
    
    func segueToMessages() {
        let vc = builder.start()
        vc.modalPresentationStyle = .fullScreen
        parentViewController?.present(vc, animated: true, completion: nil)
    }
}
