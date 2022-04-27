//
//  AuthModel.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 21.01.2022.
//

import Foundation

class AuthModel {
    
    let mainApiInteractor: MainApiInteractor = MainApiInteractorImpl()
        
    //MARK: - Public functions
    func authorize(completion: @escaping () -> (), onError: @escaping () -> ()) {
        mainApiInteractor.authorize(onSuccess: completion, onError: onError)
    }
}