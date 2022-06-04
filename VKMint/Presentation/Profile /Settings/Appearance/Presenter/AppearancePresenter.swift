//
//  AppearancePresenter.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 15.05.2022.
//

import Foundation

class AppearancePresenter {

    // MARK: - Properties
    private var interactor: AppearanceInteractor
    weak var view: AppearanceViewController?
    private weak var moduleOutput: AppearanceModuleOutput!

    init(interactor: AppearanceInteractor, view: AppearanceViewController, output: AppearanceModuleOutput) {
        self.interactor = interactor
        self.view = view
        self.moduleOutput = output
    }
}

// MARK: - AppearanceInteractorOutput
extension AppearancePresenter: AppearanceInteractorOutput {
}

// MARK: - AppearanceViewOutput
extension AppearancePresenter: AppearanceViewOutput {
    func viewWantsToClose() {
        moduleOutput?.appearenceWantsToClose()
    }
}
