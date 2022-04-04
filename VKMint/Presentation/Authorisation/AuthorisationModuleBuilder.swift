//
//  AuthorisationModuleBuilder.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 04.04.2022.
//

import Foundation
import UIKit

class AuthorisationModuleBuilder {
    
    func start() -> UIViewController {
        let view = AuthorisationView()
        let vc = AuthViewController()
        vc.view = view
        return vc
    }
}
