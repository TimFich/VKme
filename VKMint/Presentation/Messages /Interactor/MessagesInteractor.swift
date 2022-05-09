//
//  MessagesInteractor.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 30.04.2022.
//

import Foundation
import SwiftyVK

protocol MessagesInteractorInput: AnyObject {
    func getStoredOrLoadConversations(completion: @escaping ([TableViewCellData]) -> Void)
    func downloadConversations(offset: Int, completion: @escaping ([TableViewCellData]) -> Void)
}

protocol MessagesInteractorOutput: AnyObject {
    func didStartUpdatingConversations()
    func didEndUpdatingConversations()
    func needToUpdateConversations(updatedData: [TableViewCellData])
    func newMessageReceived(message: LastMessage)
}

class MessagesInteractor: MessagesInteractorInput {
    
    //MARK: - Properties
    let conversationInteractor: ConversationsApiInteractor = ConversationsApiInteractorImpl()
    let dataStoreManager: DataStoreManagerProtocol = DataStoreManager()
    let cellDataConverter: TableViewCellDataConverterProtocol = TableViewCellDataConverter()
    let longPollManager = LongPollManager.shared
    weak var output: MessagesInteractorOutput!
    
    //MARK: - Public functions
    func getStoredOrLoadConversations(completion: @escaping ([TableViewCellData]) -> Void) {
        let result = dataStoreManager.fetchConversations()
        guard let result = result else {
            output.didStartUpdatingConversations()
            conversationInteractor.getConversation(offset: 0, count: 200, completion: { [self] conv in
                let cellData = cellDataConverter.convertToCellData(conversation: conv)
                completion(cellData)
                output.didEndUpdatingConversations()
                dataStoreManager.addCDConversation(conv)
            })
            startLongPolling()
            return
        }
        let cellData = cellDataConverter.convertToCellData(conversation: result)
        completion(cellData)
        output?.didStartUpdatingConversations()
        saveUpdatedConversation()
    }
    
    func downloadConversations(offset: Int, completion: @escaping ([TableViewCellData]) -> Void) {
        conversationInteractor.getConversation(offset: offset, count: 200, completion: { conv in
            let cellData = self.cellDataConverter.convertToCellData(conversation: conv)
            completion(cellData)
        })
    }
    
    private func saveUpdatedConversation() {
        dataStoreManager.deleteConversations()
        conversationInteractor.getConversation(offset: 0, count: 200, completion: { conv in
            self.dataStoreManager.addCDConversation(conv)
            let cellData = self.cellDataConverter.convertToCellData(conversation: conv)
            self.output?.needToUpdateConversations(updatedData: cellData)
            self.output.didEndUpdatingConversations()
            self.startLongPolling()
        })
    }
    
    private func startLongPolling() {
        longPollManager.start()
        longPollManager.addOnReceiveCompletion(eventNumber: 4,completion: { data in
            var data = try! JSONSerialization.jsonObject(with: data, options: []) as! Array<Any>
            let peerId = data[2] as! Int
            let text = data[5] as! String
            let id = data[1] as! Int
            let date = data[3] as! Int
            let entity = LastMessage(peerID: peerId, id: id, date: date, text: text)
            self.dataStoreManager.replaceLastMessage(lastMessage: entity)
            DispatchQueue.main.async {
                self.output.newMessageReceived(message: entity)
            }
        })
    }
}
