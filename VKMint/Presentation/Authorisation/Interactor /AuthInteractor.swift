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
    func authorizedFailure()
}

class AuthInteractor {
    
    var mainApiInteractor: MainApiInteractor = MainApiInteractorImpl()
    
    weak var output: AuthInteractorOutput!
    
    func authorize() {
        mainApiInteractor.authorize(onSuccess: { [weak self] in
            DispatchQueue.main.async {
                self?.output.authorizedSuccesful()
            }
        }, onError: { [weak self] in
            DispatchQueue.main.async {
                self?.output.authorizedFailure()
            }
        })
    }
}

extension AuthInteractor: AuthInteractorInput {
    func signIn() {
        authorize()
    }
}

