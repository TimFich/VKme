//
//  ProfilePresenter.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 10.05.2022.
//

import Foundation

class ProfilePresenter {
    
    //MARK: - Properties
    private var interactor: ProfileInteractor
    weak var view: ProfileViewController?
    
    init(interactor: ProfileInteractor, view: ProfileViewController) {
        self.interactor = interactor
        self.view = view
    }
}

//MARK: - ProfileInteractorInput
extension ProfilePresenter: ProfileInteractorInput {
    func getDataOfUser(completion: @escaping (ProfileData) -> Void) {
        
    }
}

//MARK: - ProfileInteractorOutput
extension ProfilePresenter: ProfileInteractorOutput {
    
}

//MARK: - ProfileViewOutput
extension ProfilePresenter: ProfileViewOutput {
    func viewDidLoad() {
        interactor.getDataOfUser { result in
            self.view?.needToUpdateProfile(person: result)
        }
    }
}
