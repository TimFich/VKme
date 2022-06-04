//
//  ProfilePresenter.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 10.05.2022.
//

import Foundation
import SwiftyVK

class ProfilePresenter {

    // MARK: - Properties
    private var interactor: ProfileInteractor
    weak var view: ProfileViewController?
    private weak var moduleOutput: ProfileModuleOutput!

    init(interactor: ProfileInteractor, view: ProfileViewController, output: ProfileModuleOutput) {
        self.interactor = interactor
        self.view = view
        self.moduleOutput = output
    }
}

// MARK: - ProfileInteractorOutput
extension ProfilePresenter: ProfileInteractorOutput {
    func logoutSuccess() {
        view?.dismiss(animated: true, completion: {
            self.moduleOutput.moduleWantsToOpenAuthScreen()
        })
    }
}

// MARK: - ProfileViewOutput
extension ProfilePresenter: ProfileViewOutput {
    func itemPressed(flag: Int) {
        moduleOutput.moduleWantsToOpenSetting(flag: flag)
    }

    func signOutPressed() {
        interactor.logout()
    }

    func needToLoadData() {
        interactor.getDataOfUser { result in
            self.view?.needToUpdateProfile(person: result)
        }
    }
}
