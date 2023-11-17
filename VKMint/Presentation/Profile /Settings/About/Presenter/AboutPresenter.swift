//
//  AboutPresenter.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 16.05.2022.
//

import Foundation

class AboutPresenter {

    // MARK: - Properties
    private var interactor: AboutInteractor
    weak var view: AboutViewController?
    private weak var moduleOutput: AboutModuleOutput!

    init(interactor: AboutInteractor, view: AboutViewController, output: AboutModuleOutput) {
        self.interactor = interactor
        self.view = view
        self.moduleOutput = output
    }
}

// MARK: - AboutInteractorOutput

extension AboutPresenter: AboutInteractorOutput {
}

// MARK: - AboutViewOutput

extension AboutPresenter: AboutViewOutput {
    func viewWantsToClose() {
        moduleOutput?.aboutWantsToClose()
    }
}
