//
//  AuthInteractor.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 08.04.2022.
//

import Foundation

protocol AuthInteractorInput: AnyObject {
    func signIn()
}

protocol AuthInteractorOutput: AnyObject {
    func authorizedSuccesful()
}

class AuthInteractor {
    
    let apiInteractor: MainApiInteractor = MainApiInteractorImpl()
    
    weak var output: AuthInteractorOutput!
    
    func authorize() {
        apiInteractor.authorize(onSuccess: { [weak self] in
            self?.output.authorizedSuccesful()
        }, onError: {})
    }
}

extension AuthInteractor: AuthInteractorInput {
    func signIn() {
        authorize()
    }
}

