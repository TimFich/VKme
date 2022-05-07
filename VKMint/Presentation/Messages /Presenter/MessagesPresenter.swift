//
//  MessagesPresenter.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 03.05.2022.
//

import Foundation

class MessagesPresenter {
    
    init(interactor: MessagesInteractor, view: MessagesViewController) {
        self.interactor = interactor
        self.view = view
    }
    
    private var interactor: MessagesInteractor!
    weak var view: MessagesViewController!
    //private weak var moduleOutput: AuthModuleOutput!
}

extension MessagesPresenter: MessagesViewOutputProtocol {
    func nextButtonPressed(offset: Int) {
        interactor.downloadConversations(offset: offset, completion: { cellsData in
            self.view.dataFetched(data: cellsData)
        })
    }
    
    func viewDidLoad() {
        interactor.getStoredOrLoadConversations(completion: { cellsData in
            self.view.dataFetched(data: cellsData)
        })
    }
}

extension MessagesPresenter: MessagesInteractorOutput {
    func needToUpdateConversations(updatedData: [TableViewCellData], unreadMessagesCount: Int) {
    }
    
    func didStartUpdatingConversations() {
        //TODO: Animation
    }
    
    func didEndUpdatingConversations() {
        //TODO: Animation
    }
}
