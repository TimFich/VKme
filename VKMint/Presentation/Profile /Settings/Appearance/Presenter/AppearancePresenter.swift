//
//  AppearancePresenter.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 15.05.2022.
//

import Foundation

class AppearancePresenter {
    
    //MARK: - Properties
    private var interactor: AppearanceInteractor
    weak var view: AppearanceViewController?
    
    init(interactor: AppearanceInteractor, view: AppearanceViewController) {
        self.interactor = interactor
        self.view = view
    }
}

extension AppearancePresenter: AppearanceInteractorInput {
    
}

extension AppearancePresenter: AppearanceInteractorOutput {
    
}

extension AppearancePresenter: AppearanceViewOutput {
    
}
