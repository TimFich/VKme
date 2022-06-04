//
//  APIInteractor.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 20.01.2022.
//

import Foundation
import SwiftyVK

protocol MainApiInteractor {
    func authorize(onSuccess: @escaping () -> Void, onError: @escaping () -> Void)
    func sigout()
}

class MainApiInteractorImpl: MainApiInteractor {

    func authorize(onSuccess: @escaping () -> Void, onError: @escaping () -> Void) {
        VK.sessions.default.logIn(onSuccess: { result in
            UserDefaults.standard.set(result["user_id"], forKey: UserDefaultsKeys.userId.rawValue)
            onSuccess()
        }, onError: { _ in
            onError()
        })
    }

    func sigout() {
        VK.sessions.default.logOut()
    }
}
