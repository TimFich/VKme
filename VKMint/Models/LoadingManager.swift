//
//  LoadingManager.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 15.10.2022.
//

import Foundation

protocol LoadingManagerDelegate: AnyObject {

}

public enum LoadingStates {
    case start
    case finished
}

final class LoadingManager {

    private(set) var state: LoadingStates = .start

    private let mainInteractor: MainApiInteractor = MainApiInteractorImpl()

}

// MARK: - MainApiInteractor

extension LoadingManager: MainApiInteractor {

    func authorize(onSuccess: @escaping () -> Void, onError: @escaping () -> Void) {
        state = .start
        mainInteractor.authorize(onSuccess: onSuccess, onError: onError)
        state = .finished
    }

    func sigout() {
        state = .start
        mainInteractor.sigout()
        state = .finished
    }
}
