//
//  LockInteractor.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 26.05.2022.
//

import Foundation
import UIKit

protocol LockInteractorInput: AnyObject {
    func needPassword() -> String
}

protocol LockInteractorOutput: AnyObject {
}

class LockInteractor {

    weak var output: LockInteractorOutput!
    private let keyChainManager = KeychainManager()
}

// MARK: - LockInteractorInput

extension LockInteractor: LockInteractorInput {
    func needPassword() -> String {
        keyChainManager.getChain()
    }
}
