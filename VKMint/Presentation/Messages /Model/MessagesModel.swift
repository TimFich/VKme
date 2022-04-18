//
//  MessagesModel.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 26.01.2022.
//

import Foundation
import SwiftyVK

class MessagesModel {
    
    //MARK: - Properties
    
    let conversationApiInteractor: ConversationsApiInteractor = ConversationsApiInteractorImpl()
    let downloader: ImageDownloader = ImageDownloaderImpl()
    let usersApiInteractor: UsersApiInteractor = UsersApiInteracorImpl()
    var conversation: Conversation? = nil
    var convCellData: [TableViewCellData] = [] {
        didSet {
            if convCellData.count == convCount {
                delegate?.didLoadConversations()
            }
        }
    }
    var chatsCellData: [TableViewCellData] = [] {
        didSet {
            if chatsCellData.count == chatsCount {
                delegate?.didLoadChats()
            }
        }
    }
    weak var delegate: MessageModelDelegate? = nil
    
    //MARK: - Private properties
    private var convCount = 0
    private var chatsCount = 0
    
    init() {
        loadData()
    }
    
    func loadData() {
        conversationApiInteractor.getConversation(completion: { result in
            self.conversation = result
            self.processData()
        })
    }
    
    private func processData() {
        let items = conversation?.items
        guard items != nil else { return }
        for item in items! {
            if item.conversation.peer.type.rawValue == TypeEnum.user.rawValue {
                convCount += 1
            } else {
                chatsCount += 1
            }
        }
        for item in items! {
            if item.conversation.peer.type.rawValue == TypeEnum.user.rawValue {
                loadConversation(item: item)
            } else {
                let cellData = TableViewCellData()
                cellData.title = item.conversation.chatSettings?.title ?? ""
                cellData.lastMessage = item.lastMessage.text
                if item.conversation.chatSettings?.photo == nil {
                    
                    cellData.avatarOfChat = UIImage(named: "VK_Logo") ?? UIImage()
                    
                } else {
                    downloader.downloadImage(urlOfPhoto: item.conversation.chatSettings?.photo?.photoMini ?? "") { result in
                        cellData.avatarOfChat = result
                    }
                    
                }
                chatsCellData.append(cellData)
            }
        }
    }
    
    private func loadConversation(item: Item) {
        usersApiInteractor.getUserByID(userId: item.conversation.peer.id, completion: { user in
            let cellData = TableViewCellData()
            cellData.title = user.firstName + " " + user.lastName
            cellData.lastMessage = item.lastMessage.text
            self.downloader.getUserAvatar(userId: item.conversation.peer.id) { result in
                if result[0].photo == nil {
                    cellData.avatarOfChat = UIImage(named: "VK_Logo") ?? UIImage()
                } else {
                    print(result)
                    self.downloader.downloadImage(urlOfPhoto: result[0].photo!) { res in
                        cellData.avatarOfChat = res
                    }
                }
                self.convCellData.append(cellData)
            }
        })
    }
}
