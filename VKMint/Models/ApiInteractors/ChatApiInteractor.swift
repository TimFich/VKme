//
//  ChatApiInteractor.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 29.05.2022.
//

import Foundation
import SwiftyVK

protocol ChatApiInteractor {
    func getChatData(id: Int, completion: @escaping (ChatResponse) -> Void)
}

final class ChatApiInteractorImpl: ChatApiInteractor {
    func getChatData(id: Int, completion: @escaping (ChatResponse) -> Void) {
        VK.API.Messages.getHistory([Parameter.peerId: "\(id)",
                                    Parameter.count: "100",
                                    Parameter.extended: "1"])
        .onSuccess({ result in
            let chat = try! JSONDecoder().decode(ChatResponse.self, from: result)
            completion(chat)
        }).send()
    }
}
