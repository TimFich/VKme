//
//  AboutPresenter.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 16.05.2022.
//

import Foundation

class AboutPresenter {
    
    //MARK: - Private Properties
    
    private var interactor: AboutInteractor
    
    //MARK: - Properties
    
    weak var view: AboutViewController?
    
    //MARK: - Life cycle
    
    init(interactor: AboutInteractor, view: AboutViewController) {
        self.interactor = interactor
        self.view = view
    }
}

//MARK: - AboutInteractorInput

extension AboutPresenter: AboutInteractorInput {
    
}

//MARK: - AboutInteractorOutput

extension AboutPresenter: AboutInteractorOutput {
    
}

//MARK: - AboutViewOutput

extension AboutPresenter: AboutViewOutput {
    
}
