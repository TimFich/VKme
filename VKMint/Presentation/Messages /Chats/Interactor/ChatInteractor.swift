//
//  ChatInteractor.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 29.05.2022.
//

import Foundation

protocol ChatInteractorInput: AnyObject {
    func getChatData(completion: @escaping (ChatData) -> Void)
}

protocol ChatInteractorOutput: AnyObject {
    
}

class ChatInteractor {
    
    weak var output: ChatInteractorOutput!
    private let id: Int
    private let chatInteractor: ChatApiInteractor = ChatApiInteractorImpl()
    private let converter = ChatDataConverter()
    
    init(id: Int) {
        self.id = id
        print(id)
    }
}

//MARK: - ChatInteractorInput
extension ChatInteractor: ChatInteractorInput {
    func getChatData(completion: @escaping (ChatData) -> Void) {
        chatInteractor.getChatData(id: id) { result in
            let buf = self.converter.convert(data: result)
            completion(buf)
        }
    }
}
 
