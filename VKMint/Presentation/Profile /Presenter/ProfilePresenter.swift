//
//  ProfilePresenter.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 10.05.2022.
//

import Foundation
import SwiftyVK

class ProfilePresenter {
    
    //MARK: - Properties
    private var interactor: ProfileInteractor
    weak var view: ProfileViewController?
    private weak var moduleOutput: ProfileModuleOutput!
    
    init(interactor: ProfileInteractor, view: ProfileViewController) {
        self.interactor = interactor
        self.view = view
    }
}

//MARK: - ProfileInteractorInput
extension ProfilePresenter: ProfileInteractorInput {
    func performViewController(parentViewController: UINavigationController, flag: Int) {
        
    }
    
    func logout() {
        
    }
    
    func getDataOfUser(completion: @escaping (ProfileData) -> Void) {
        
    }
}

//MARK: - ProfileInteractorOutput
extension ProfilePresenter: ProfileInteractorOutput {
    func logoutSuccess() {
        //TODO: - свзать с MainFlowCoordinator
        
    }
}

//MARK: - ProfileViewOutput
extension ProfilePresenter: ProfileViewOutput {
    func itemPressed(parentViewController: UINavigationController, flag: Int) {
        interactor.performViewController(parentViewController: parentViewController, flag: flag)
    }
    
    func signOutPressed() {
        interactor.logout()
    }
    
    func viewDidLoad() {
        interactor.getDataOfUser { result in
            self.view?.needToUpdateProfile(person: result)
        }
    }
}
