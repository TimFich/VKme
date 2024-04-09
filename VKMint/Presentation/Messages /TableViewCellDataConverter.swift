//
//  File.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 03.05.2022.
//

import Foundation
import UIKit

protocol TableViewCellDataConverterProtocol {
    func convertToCellData(conversation: CDConversations) -> [TableViewCellData]

    func convertToCellData(conversation: Conversation) -> [TableViewCellData]
}

class TableViewCellDataConverter: TableViewCellDataConverterProtocol {
    func convertToCellData(conversation: Conversation) -> [TableViewCellData] {
        var result: [TableViewCellData] = []
        let imageDownloader = ImageDownloader()
        let items = conversation.items
        for item in items {
            let type = TypeEnum(rawValue: item.conversation.peer.type.rawValue)
            guard let type = type else { return [] }
            switch type {
            case .chat:
                let unreadCount = item.conversation.unreadCount ?? 0
                let title = item.conversation.chatSettings?.title ?? ""
                let lastMessage = item.lastMessage.text
                let avatarOfChat = UIImage(named: "VK_Logo") ?? UIImage()
                let cellData = TableViewCellData(peerId: item.conversation.peer.id,title: title, avatarOfChat: avatarOfChat, lastMessage: lastMessage, type: type, unreadCount: unreadCount)
                result.append(cellData)
                if item.conversation.chatSettings?.photo != nil {
                    imageDownloader.downloadImage(urlOfPhoto: (item.conversation.chatSettings?.photo!.photoMini)!, completion: { image in
                        cellData.avatarOfChat = image
                    })
                }
            case .group:
                print("--need to process groups")
            case .user:
                let peerId = item.conversation.peer.id
                let profile = conversation.profiles.first(where: {
                    $0.id == peerId
                })
                guard let profile = profile else { return [] }
                let fullName = profile.firstName + " "  + profile.lastName
                let avatarOfChat = UIImage(named: "VK_Logo")!
                let unreadCount = item.conversation.unreadCount ?? 0
                let lastMessage = item.lastMessage.text
                let cellData = TableViewCellData(peerId: item.conversation.peer.id, title: fullName, avatarOfChat: avatarOfChat, lastMessage: lastMessage, type: type, unreadCount: unreadCount)
                result.append(cellData)
                guard let photoRef = profile.photo_100 else {
                    continue
                }
                imageDownloader.downloadImage(urlOfPhoto: photoRef, completion: { image in
                    cellData.avatarOfChat = image
                })
            }
        }
        return result
    }

    func convertToCellData(conversation: CDConversations) -> [TableViewCellData] {
        var result: [TableViewCellData] = []
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
                let cellData = TableViewCellData(peerId: Int(exactly: item.conversation.peer.id)!, title: title, avatarOfChat: avatarOfChat, lastMessage: lastMessage, type: type, unreadCount: Int(unreadCount))
                result.append(cellData)
                if item.conversation.chatSettings?.photo != nil {
                    let data = Data(referencing: (item.conversation.chatSettings?.photo)!)
                    cellData.avatarOfChat = UIImage(data: data)!
                }
            case .group:
                print("need to process groups")
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
                let cellData = TableViewCellData(peerId: Int(exactly: item.conversation.peer.id)!, title: fullName, avatarOfChat: avatarOfChat, lastMessage: lastMessage, type: type, unreadCount: Int(unreadCount))
                result.append(cellData)
            }
        }
        return result
    }
}
