//
//  AuthModel.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 21.01.2022.
//

import Foundation

class AuthModel {
        
    //MARK: - Public functions
    func authorize(completion: @escaping () -> (), onError: @escaping () -> ()) {
        APIInteractor.authorize(onSuccess: completion, onError: onError)
    }
}
