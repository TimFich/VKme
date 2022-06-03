//
//  MessagesPresenter.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 03.05.2022.
//

import Foundation

class MessagesPresenter {
    
    private var interactor: MessagesInteractor!
    weak var view: MessagesViewController!
    private weak var moduleOutput: MessagesModuleOutput!
    
    init(interactor: MessagesInteractor, view: MessagesViewController, output: MessagesModuleOutput) {
        self.interactor = interactor
        self.view = view
        self.moduleOutput = output
    }
}

//MARK: - MessagesViewOutputProtocol
extension MessagesPresenter: MessagesViewOutputProtocol {
    
    func wantsToOpenChat(id: Int, title: String) {
        moduleOutput.openChat(id: id, title: title)
    }
    
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

// MARK: - MessagesInteractorOutput
extension MessagesPresenter: MessagesInteractorOutput {
    func newMessageReceived(message: LastMessage) {
        view.updateLastMessage(message: message)
    }
    
    func needToUpdateConversations(updatedData: [MessageTableViewCellData]) {
        view.dataFetched(data: updatedData)
    }
    
    func didStartUpdatingConversations() {
        view.didStartUpdatingConversations()
    }
    
    func didEndUpdatingConversations() {
        view.didEndUpdatingConversations()
    }
}
