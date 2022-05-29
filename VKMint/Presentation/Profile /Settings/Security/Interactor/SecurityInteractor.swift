//
//  SecurityInteractor.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 24.05.2022.
//

import Foundation
import UIKit

protocol SecurityInteractorInput: AnyObject {
    func isExist() -> Bool
}

protocol SecurityInteractorOutput: AnyObject {
    
}

class SecurityInteractor {
    
    weak var output: SecurityInteractorOutput!
    private let keychainManager = KeychainManager()
}

//MARK: - SecurityInteractorInput
extension SecurityInteractor: SecurityInteractorInput {
    func isExist() -> Bool {
        keychainManager.isExist()
    }
}





