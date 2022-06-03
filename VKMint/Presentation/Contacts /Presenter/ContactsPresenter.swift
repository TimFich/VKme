//
//  ContactsPresenter.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 09.05.2022.
//

import Foundation

class ContactsPresenter {
    
    // MARK: - Properties
    private var interactor: СontactsInteractor
    weak var view: ContactsViewController?

    init(interactor: СontactsInteractor, view: ContactsViewController) {
        self.interactor = interactor
        self.view = view
    }
}

// MARK: - ContactsViewOutput
extension ContactsPresenter: ContactsViewOutput {
    func viewDidLoad() {
        interactor.fetchUsers(completion: { cellData in
            self.view?.needToUpdateContacts(updatedData: cellData)
        })
    }
}

// MARK: - ContactsInteractorOutput
extension ContactsPresenter: ContactsInteractorOutput {
    func needToUpdateContacts(updatedData: [ContactsTableViewCellData]) {
        view?.needToUpdateContacts(updatedData: updatedData)
    }
    
    func startUpdatingUsers() {
        view?.startUpdatingUsers()
    }
    
    func endUpdatingUsers() {
        view?.endUpdatingUsers()
    }
}
