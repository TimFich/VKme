//
//  AuthInteractorOutputForFailerMock.swift
//  VKMintTests
//
//  Created by Тимур Миргалиев on 18.04.2022.
//

import Foundation

@testable import VKMint

class AuthInteractorOutputForFailerMock: AuthInteractorOutput {

    var isSuccessful: Bool = true

    func authorizedSuccesful() {
    }

    func authorizedFailure() {
        isSuccessful = false
    }
}
