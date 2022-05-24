//
//  SecurityPresenter.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 24.05.2022.
//

import Foundation

class SecurityPresenter {
    
    //MARK: - Properties
    private var interactor: SecurityInteractor
    weak var view: SecurityViewController?
    
    init(interactor: SecurityInteractor, view: SecurityViewController) {
        self.interactor = interactor
        self.view = view
    }
}

//MARK: - SecurityInteractorInput
extension SecurityPresenter: SecurityInteractorInput {
    
}

//MARK: - SecurityInteractorOutput
extension SecurityPresenter: SecurityInteractorOutput {
    
}

extension SecurityPresenter: SecurityViewOutput {
    
}
