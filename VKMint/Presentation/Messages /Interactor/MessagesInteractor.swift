//
//  MessagesInteractor.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 30.04.2022.
//

import Foundation

protocol MessagesInteractorInput: AnyObject {
    func getStoredOrLoadConversations(completion: @escaping ([TableViewCellData]) -> Void)
    func downloadConversations(offset: Int, completion: @escaping ([TableViewCellData]) -> Void)
}

protocol MessagesInteractorOutput: AnyObject {
    func didStartUpdatingConversations()
    func didEndUpdatingConversations()
    func needToUpdateConversations(updatedData: [TableViewCellData], unreadMessagesCount: Int)
}

class MessagesInteractor: MessagesInteractorInput {
    
    //MARK: - Properties
    let conversationInteractor: ConversationsApiInteractor = ConversationsApiInteractorImpl()
    let dataStoreManager: DataStoreManagerProtocol = DataStoreManager()
    let cellDataConverter: TableViewCellDataConverterProtocol = TableViewCellDataConverter()
    weak var output: MessagesInteractorOutput!
    
    //MARK: - Public functions
    func getStoredOrLoadConversations(completion: @escaping ([TableViewCellData]) -> Void) {
        let result = dataStoreManager.fetchConversations()
        guard let result = result else {
            conversationInteractor.getConversation(offset: 0, count: 200, completion: { [self] conv in
                let cellData = cellDataConverter.convertToCellData(conversation: conv)
                completion(cellData)
            })
            return
        }
        let cellData = cellDataConverter.convertToCellData(conversation: result)
        completion(cellData)
        output?.didStartUpdatingConversations()
        updateConversations()
    }
    
    func downloadConversations(offset: Int, completion: @escaping ([TableViewCellData]) -> Void) {
        conversationInteractor.getConversation(offset: offset, count: 200, completion: { conv in
            let cellData = self.cellDataConverter.convertToCellData(conversation: conv)
            completion(cellData)
        })
    }
    
    private func updateConversations() {
        conversationInteractor.getConversation(offset: 0, count: 0, completion: { conv in
            if conv.unreadCount == 0 {
                self.output?.didEndUpdatingConversations()
            } else {
                self.saveUpdatedConversation()
            }
        })
    }
    
    private func saveUpdatedConversation() {
        conversationInteractor.getConversation(offset: 0, count: 200, completion: { conv in
            self.dataStoreManager.addCDConversation(conv)
            let cellData = self.cellDataConverter.convertToCellData(conversation: conv)
            self.output?.needToUpdateConversations(updatedData: cellData, unreadMessagesCount: conv.unreadCount ?? 0)
        })
    }
}
