//
//  AuthInteractorOutputForSuccessMock.swift
//  VKMintTests
//
//  Created by Тимур Миргалиев on 18.04.2022.
//

import Foundation
@testable import VKMint

class AuthInteractorOutputForSuccessMock: AuthInteractorOutput {

    var isSuccessful: Bool = false

    func authorizedSuccesful() {
        isSuccessful = true
    }

    func authorizedFailure() {
    }
}
