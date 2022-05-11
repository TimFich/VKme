//
//  AuthPresenter.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 08.04.2022.
//

import Foundation
import UIKit

class AuthPresenter {
   
    //MARK: - Properties
    private var interactor: AuthInteractorInput!
    weak var view: AuthViewController!
    private weak var moduleOutput: AuthModuleOutput!
    
    init(interactor: AuthInteractorInput, moduleOutput: AuthModuleOutput) {
        self.interactor = interactor
        self.moduleOutput = moduleOutput
    }
}

//MARK: - AuthViewOutput
extension AuthPresenter: AuthViewOutput {
    func signInButtonPressed() {
        interactor.signIn()
    }
}

//MARK: - AuthInteractorOutput
extension AuthPresenter: AuthInteractorOutput {
    func authorizedSuccesful() {
        moduleOutput.moduleWantsToOpenTapBar(animated: true)
    }
    
    func authorizedFailure() {
    }
}

