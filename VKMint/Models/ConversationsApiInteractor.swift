//
//  ConversationsApiInteractor.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 18.04.2022.
//

import Foundation
import SwiftyVK

protocol ConversationsApiInteractor {
    func getConversation(offset: Int, count: Int, completion: @escaping (Conversation) -> ())
}

class ConversationsApiInteractorImpl: ConversationsApiInteractor {
    
    private var offset: Int = 0
    
    func getConversation(offset: Int, count: Int, completion: @escaping (Conversation) -> ()) {
        VK.API.Messages.getConversations([Parameter.count: "\(count)", Parameter.offset: "\(offset)", Parameter.extended: "1", Parameter.fields: "photo_100"])
            .onSuccess({ result in
                do {
                    let conversation = try? JSONDecoder().decode(Conversation.self, from: result)
                    DispatchQueue.main.async {
//                        print(conversation?.items.count)
                        completion(conversation!)
                    }
                } catch let error {
                    print(error)
                }
            }).send()
    }
}
