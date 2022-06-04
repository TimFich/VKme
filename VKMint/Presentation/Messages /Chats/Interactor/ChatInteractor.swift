//
//  ChatInteractor.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 29.05.2022.
//

import Foundation

protocol ChatInteractorInput: AnyObject {
    func getChatData(completion: @escaping (ChatData) -> Void)
    func sendMesaage(completion: @escaping ((Int) -> Void), text: String)
}

protocol ChatInteractorOutput: AnyObject {
}

class ChatInteractor {

    private let sendApiInteractor: SenderApiInteractor = SenderApiInteractorImpl()

    weak var output: ChatInteractorOutput!
    private let id: Int
    private let chatInteractor: ChatApiInteractor = ChatApiInteractorImpl()
    private let converter = ChatDataConverter()

    init(id: Int) {
        self.id = id
        print(id)
    }
}

// MARK: - ChatInteractorInput
extension ChatInteractor: ChatInteractorInput {
    func sendMesaage(completion: @escaping ((Int) -> Void), text: String) {

        if String(id).starts(with: "2000000000") {
            sendApiInteractor.sendMessage(completion: completion, userId: nil, peerId: id, randomId: Int.random(in: 0...5000000000), message: text)
        } else {
            sendApiInteractor.sendMessage(completion: completion, userId: id, peerId: nil, randomId: Int.random(in: 0...5000000000), message: text)
        }

    }

    func getChatData(completion: @escaping (ChatData) -> Void) {
        chatInteractor.getChatData(id: id) { result in
            let buf = self.converter.convert(data: result)
            completion(buf)
        }
    }
}
