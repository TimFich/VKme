//
//  MainApiInteractorMock.swift
//  VKMintTests
//
//  Created by Тимур Миргалиев on 18.04.2022.
//

import Foundation
@testable import VKMint

class MainApiInteractorForSuccessMock: MainApiInteractor {
    func sigout() {
    }

    func authorize(onSuccess: @escaping () -> Void, onError: @escaping () -> Void) {
        onSuccess()
    }
}
