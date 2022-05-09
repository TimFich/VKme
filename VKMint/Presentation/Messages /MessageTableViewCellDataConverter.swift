//
//  File.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 03.05.2022.
//

import Foundation
import UIKit

protocol MessageTableViewCellDataConverterProtocol {
    func convertToCellData(conversation: CDConversations) -> [MessageTableViewCellData]
    
    func convertToCellData(conversation: Conversation, completion: @escaping ([MessageTableViewCellData]) -> Void)
}

class MessageTableViewCellDataConverter: MessageTableViewCellDataConverterProtocol {
    func convertToCellData(conversation: Conversation, completion: @escaping ([MessageTableViewCellData]) -> Void) {
        let imageDownloader = ImageDownloader()
        let helper = EscapingClosureHelper<MessageTableViewCellData>(count: conversation.items.count)
        let items = conversation.items
        for item in items {
            let type = TypeEnum(rawValue: item.conversation.peer.type.rawValue)
            guard let type = type else { return }
            switch type {
            case .chat:
                let unreadCount = item.conversation.unreadCount ?? 0
                let title = item.conversation.chatSettings?.title ?? ""
                let lastMessage = item.lastMessage.text
                let avatarOfChat = UIImage(named: "VK_Logo") ?? UIImage()
                let cellData = MessageTableViewCellData(peerId: item.conversation.peer.id,title: title, avatarOfChat: avatarOfChat, lastMessage: lastMessage, type: type, unreadCount: unreadCount)
                helper.result.append(cellData)
                if item.conversation.chatSettings?.photo != nil {
                    imageDownloader.downloadImage(urlOfPhoto: (item.conversation.chatSettings?.photo!.photoMini)!, completion: { image in
                        cellData.avatarOfChat = image
                        helper.increase()
                        if helper.isEnough() {
                            completion(helper.result)
                        }
                    })
                } else {
                    helper.photosCount -= 1
                }
            case .group:
                // TODO: Made groups
                helper.photosCount -= 1
            case .user:
                let peerId = item.conversation.peer.id
                let profile = conversation.profiles.first(where: {
                    $0.id == peerId
                })
                guard let profile = profile else { return  }
                let fullName = profile.firstName + " "  + profile.lastName
                let avatarOfChat = UIImage(named: "VK_Logo")!
                let unreadCount = item.conversation.unreadCount ?? 0
                let lastMessage = item.lastMessage.text
                let cellData = MessageTableViewCellData(peerId: item.conversation.peer.id, title: fullName, avatarOfChat: avatarOfChat, lastMessage: lastMessage, type: type, unreadCount: unreadCount)
                helper.result.append(cellData)
                imageDownloader.downloadImage(urlOfPhoto: profile.photo_100!, completion: { image in
                    cellData.avatarOfChat = image
                    helper.increase()
                    if helper.isEnough() {
                        completion(helper.result)
                    }
                })
            }
        }
    }
    
    func convertToCellData(conversation: CDConversations) -> [MessageTableViewCellData] {
        var result: [MessageTableViewCellData] = []
        let items = Array(conversation.items) as! Array<CDItems>
        for item in items {
            let type = TypeEnum(rawValue: item.conversation.peer.type)
            guard let type = type else { return [] }
            switch type {
            case .chat:
                let title = item.conversation.chatSettings?.title ?? ""
                let lastMessage = item.lastMessage?.text ?? ""
                let avatarOfChat = UIImage(named: "VK_Logo") ?? UIImage()
                let unreadCount = item.conversation.unreadCount
                let cellData = MessageTableViewCellData(peerId: Int(exactly: item.conversation.peer.id)!, title: title, avatarOfChat: avatarOfChat, lastMessage: lastMessage, type: type, unreadCount: Int(unreadCount))
                result.append(cellData)
                if item.conversation.chatSettings?.photo != nil {
                    let data = Data(referencing: (item.conversation.chatSettings?.photo)!)
                    cellData.avatarOfChat = UIImage(data: data)!
                }
            case .group:
                // TODO: Made groups
                print("Need to process groups")
            case .user:
                let peerId = item.conversation.peer.id
                let profiles = Array(conversation.profiles) as! Array<CDUserItems>
                let profile = profiles.first(where: {
                    $0.id == peerId
                })
                guard let profile = profile else { return [] }
                let fullName = profile.firstName + " " + profile.lastName
                let data = Data(referencing: profile.photo)
                let avatarOfChat = UIImage(data: data)!
                let lastMessage = item.lastMessage?.text ?? ""
                let unreadCount = item.conversation.unreadCount
                let cellData = MessageTableViewCellData(peerId: Int(exactly: item.conversation.peer.id)!, title: fullName, avatarOfChat: avatarOfChat, lastMessage: lastMessage, type: type, unreadCount: Int(unreadCount))
                result.append(cellData)
            }
        }
        return result
    }
}
