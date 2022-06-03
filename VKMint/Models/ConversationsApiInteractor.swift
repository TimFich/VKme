//
//  ConversationsApiInteractor.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 18.04.2022.
//

import Foundation
import SwiftyVK

protocol ConversationsApiInteractor {
    func getConversation(offset: Int, count: Int, completion: @escaping (Conversation) -> Void)
}

class ConversationsApiInteractorImpl: ConversationsApiInteractor {
    
    private var offset: Int = 0
    
    func getConversation(offset: Int, count: Int, completion: @escaping (Conversation) -> Void) {
        VK.API.Messages.getConversations([Parameter.count: "\(count)", Parameter.offset: "\(offset)", Parameter.extended: "1", Parameter.fields: "photo_100"])
            .onSuccess({ result in
                    let conversation = try? JSONDecoder().decode(Conversation.self, from: result)
                    DispatchQueue.main.async {
                        completion(conversation!)
                    }
            }).send()
    }
}
