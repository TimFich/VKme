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
                let title = item.conversation.chatSettings?.title ?? ""
                let lastMessage = item.lastMessage.text
                let avatarOfChat = UIImage(named: "VK_Logo") ?? UIImage()
                let cellData = TableViewCellData(title: title, avatarOfChat: avatarOfChat, lastMessage: lastMessage, type: type)
                result.append(cellData)
                if item.conversation.chatSettings?.photo != nil {
                    imageDownloader.downloadImage(urlOfPhoto: (item.conversation.chatSettings?.photo!.photoMini)!, completion: { image in
                        cellData.avatarOfChat = image
                    })
                }
            case .group:
                // TODO: Made groups
                print("need to process groups")
            case .user:
                let peerId = item.conversation.peer.id
                let profile = conversation.profiles.first(where: {
                    $0.id == peerId
                })
                guard let profile = profile else { return [] }
                let fullName = profile.firstName + " "  + profile.lastName
                let avatarOfChat = UIImage(named: "VK_Logo")!
                let lastMessage = item.lastMessage.text
                let cellData = TableViewCellData(title: fullName, avatarOfChat: avatarOfChat, lastMessage: lastMessage, type: type)
                result.append(cellData)
                if profile.photo != nil {
                    imageDownloader.downloadImage(urlOfPhoto: profile.photo_100!, completion: { image in
                        cellData.avatarOfChat = image
                    })
                }
            }
        }
        return result
    }
    
    func convertToCellData(conversation: CDConversations) -> [TableViewCellData] {
        var result: [TableViewCellData] = []
        let items = Array(conversation.items)
        for item in items {
            let type = TypeEnum(rawValue: item.conversation.peer.type)
            guard let type = type else { return [] }
            switch type {
            case .chat:
                let title = item.conversation.chatSettings?.title ?? ""
                let lastMessage = item.lastMessage?.text ?? ""
                let avatarOfChat = UIImage(named: "VK_Logo") ?? UIImage()
                let cellData = TableViewCellData(title: title, avatarOfChat: avatarOfChat, lastMessage: lastMessage, type: type)
                result.append(cellData)
                if item.conversation.chatSettings?.photo != nil {
                    let data = Data(referencing: (item.conversation.chatSettings?.photo)!)
                    cellData.avatarOfChat = UIImage(data: data)!
                }
            case .group:
                // TODO: Made groups
                print("need to process groups")
            case .user:
                let peerId = item.conversation.peer.id
                let profile = conversation.profiles.first(where: {
                    $0.id == peerId
                })
                guard let profile = profile else { return [] }
                let fullName = profile.firstName + " " + profile.lastName
                let data = Data(referencing: profile.photo)
                let avatarOfChat = UIImage(data: data)!
                let lastMessage = item.lastMessage?.text ?? ""
                let cellData = TableViewCellData(title: fullName, avatarOfChat: avatarOfChat, lastMessage: lastMessage, type: type)
                result.append(cellData)
            }
        }
        return result
    }
}
