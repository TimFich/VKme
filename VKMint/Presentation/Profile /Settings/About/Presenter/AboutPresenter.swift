//
//  AboutPresenter.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 16.05.2022.
//

import Foundation

class AboutPresenter {
    
    //MARK: - Properties
    private var interactor: AboutInteractor
    weak var view: AboutViewController?
    
    init(interactor: AboutInteractor, view: AboutViewController) {
        self.interactor = interactor
        self.view = view
    }
}

extension AboutPresenter: AboutInteractorInput {
    
}

extension AboutPresenter: AboutInteractorOutput {
    
}

extension AboutPresenter: AboutViewOutput {
    
}
