//
//  LockInteractor.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 26.05.2022.
//

import Foundation
import UIKit

protocol LockInteractorInput: AnyObject {
    func perform(parentViewController: UINavigationController)
}

protocol LockInteractorOutput: AnyObject {
    
}


class LockInteractor {
    
    weak var output: LockInteractorOutput!
}

//MARK: - LockInteractorInput
extension LockInteractor: LockInteractorInput {
    func perform(parentViewController: UINavigationController) {
        let coordinator = SettingsFlowCoordinator(parentViewController: parentViewController, flag: 2, door: true)
        coordinator.start(animated: true)
    }
}





