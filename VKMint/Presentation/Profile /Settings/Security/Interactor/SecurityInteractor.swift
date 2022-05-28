//
//  SecurityInteractor.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 24.05.2022.
//

import Foundation
import UIKit

protocol SecurityInteractorInput: AnyObject {
    func performPinCodeScreen(parentViewController: UINavigationController, flag: Bool)
}

protocol SecurityInteractorOutput: AnyObject {
    
}

class SecurityInteractor {
    
    weak var output: SecurityInteractorOutput!
}

//MARK: - SecurityInteractorInput
extension SecurityInteractor: SecurityInteractorInput {
    func performPinCodeScreen(parentViewController: UINavigationController, flag: Bool) {
        let coordinator = LockScreenFlowCoordinator(parentViewController: parentViewController, flag: flag)
        coordinator.start(animated: true)
    }
}





