//
//  ChatInteractor.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 29.05.2022.
//

import Foundation

protocol ChatInteractorInput: AnyObject {
    func getChatData(completion: (ChatData) -> Void)
}

protocol ChatInteractorOutput: AnyObject {
    
}

class ChatInteractor {
    
    weak var output: ChatInteractorOutput!
    private let id: Int
    
    init(id: Int) {
        self.id = id
    }
}

//MARK: - ChatInteractorInput
extension ChatInteractor: ChatInteractorInput {
    func getChatData(completion: (ChatData) -> Void) {
        
    }
}
 
