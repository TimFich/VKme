//
//  ConversationsApiInteractor.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 18.04.2022.
//

import Foundation
import SwiftyVK

protocol ConversationsApiInteractor {
    func getConversation(completion: @escaping (Conversation) -> ())
}

class ConversationsApiInteractorImpl: ConversationsApiInteractor {
    
    func getConversation(completion: @escaping (Conversation) -> ()) {
        VK.API.Messages.getConversations(.empty)
            .onSuccess({ result in
                do {
                    let conversation = try? JSONDecoder().decode(Conversation.self, from: result)
                    DispatchQueue.main.async {
                        completion(conversation!)
                    }
                } catch let error {
                    print(error)
                }
            }).send()
    }
}
