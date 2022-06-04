//
//  AuthInteractorOutputForFailerMock.swift
//  VKMintTests
//
//  Created by Тимур Миргалиев on 18.04.2022.
//

import Foundation
@testable import VKMint

class MainApiInteractorForFailerMock: MainApiInteractor {
    func sigout() {
    }

    func authorize(onSuccess: @escaping () -> Void, onError: @escaping () -> Void) {
        onError()
    }
}
