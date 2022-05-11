//
//  APIInteractor.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 20.01.2022.
//

import Foundation
import SwiftyVK

protocol MainApiInteractor {
    func authorize(onSuccess: @escaping () -> (), onError: @escaping () -> ())
}

class MainApiInteractorImpl: MainApiInteractor {
    
    func authorize(onSuccess: @escaping () -> (), onError: @escaping () -> ()) {
        VK.sessions.default.logIn(onSuccess: {
            _ in
            onSuccess()
        }, onError: {
            _ in
            onError()
        })
    }
}
