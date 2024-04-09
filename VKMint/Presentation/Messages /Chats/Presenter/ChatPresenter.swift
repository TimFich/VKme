//
//  ChatPresenter.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 29.05.2022.
//

import Foundation

class ChatPresenter {

    weak var view: ChatViewController?
    private var interactor: ChatInteractor

    init(interactor: ChatInteractor, view: ChatViewController) {
        self.interactor = interactor
        self.view = view
    }
}

// MARK: - ChatInteractorOutput
extension ChatPresenter: ChatInteractorOutput {
}

// MARK: - ChatViewOutput
extension ChatPresenter: ChatViewOutput {
    func needToSendMessage(completion: @escaping ((Int) -> Void), textOfMessage: String) {
        interactor.sendMesaage(completion: completion, text: textOfMessage)
    }

    func getChatData(completion: @escaping (ChatData) -> Void) {
        interactor.getChatData(completion: completion)
    }
}
