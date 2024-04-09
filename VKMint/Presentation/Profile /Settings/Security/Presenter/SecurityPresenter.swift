//
//  SecurityPresenter.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 24.05.2022.
//

import Foundation
import UIKit

class SecurityPresenter {

    // MARK: - Properties
    private var interactor: SecurityInteractor
    weak var view: SecurityViewController?
    private weak var moduleOutput: SecurityModuleOutput!

    init(interactor: SecurityInteractor, view: SecurityViewController, output: SecurityModuleOutput) {
        self.interactor = interactor
        self.view = view
        self.moduleOutput = output
    }
}

// MARK: - SecurityInteractorOutput
extension SecurityPresenter: SecurityInteractorOutput {
}

// MARK: - SecurityViewOutput
extension SecurityPresenter: SecurityViewOutput {
    func isExist() -> Bool {
        interactor.isExist()
    }

    func viewWantsToClose() {
        moduleOutput?.securityWantsToClose()
    }

    func openLockScreen() {
        moduleOutput.openLockScreen()
    }
}
