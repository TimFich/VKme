//
//  SenderApiInteractor.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 03.06.2022.
//

import Foundation
import SwiftyVK

protocol SenderApiInteractor {
    func sendMessage(completion: @escaping ((Int) -> Void), userId: Int?, peerId: Int?, randomId: Int, message: String)
}

class SenderApiInteractorImpl: SenderApiInteractor {

    func sendMessage(completion: @escaping ((Int) -> Void), userId: Int?, peerId: Int?, randomId: Int, message: String) {
        if let id = userId {
            VK.API.Messages.send([Parameter.userId: "\(id)", Parameter.randomId: "\(randomId)", Parameter.message: "\(message)"]).onSuccess({ result in
                let response = try! JSONDecoder().decode(ResponseOfMessage.self, from: result)
                completion(response.messageId)
            }).send()
        } else {
            VK.API.Messages.send([Parameter.peerId: "\(peerId!)", Parameter.randomId: "\(randomId)", Parameter.message: "\(message)"]).onSuccess({ result in
                let response = try! JSONDecoder().decode(ResponseOfMessage.self, from: result)
                completion(response.messageId)
            }).send()
        }
    }
}
