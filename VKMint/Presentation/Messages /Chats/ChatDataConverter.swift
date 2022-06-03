//
//  ChatDataConverter.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 30.05.2022.
//

import Foundation
import MessageKit

class ChatDataConverter {
    
    var idToAvatar: [Int: URL?] = [:]
    
    func convert(data: ChatResponse) -> ChatData {
        
        var chatUnits: [ChatUnit] = []
        for profile in data.profiles {
            idToAvatar[profile.id] = URL(string: profile.photo_100!)
        }
        
        for item in data.items {
            
            if item.attachments.isEmpty {
                chatUnits.append(convertTextMessage(item))
            } else {
                let type = item.attachments[0].type
                if  type == "audio" {
                    chatUnits.append(convertAudioMessage(item))
                } else if type == "photo" {
                    chatUnits.append(convertPhotoMessage(item))
                } else if type == "sticker" {
                    chatUnits.append(convertStickerMessage(item))
                } else if type == "audio_message" {
                    chatUnits.append(convertVoiceMessage(item))
                }
            }
        }
        return ChatData(content: chatUnits)
    }
    
    func convertTextMessage(_ item: ChatItem) -> ChatUnit {
        let avatarUrl = idToAvatar[item.fromID] ?? nil
        
        return ChatUnit(sender: ChatUser(senderId: "\(item.fromID)", displayName: "", avatar: avatarUrl), messageId: "\(item.conversationMessageID)", sentDate: Date.init(timeIntervalSince1970: TimeInterval(item.date)), kind: MessageKind.text(item.text))
    }
    
    func convertAudioMessage(_ item: ChatItem) -> ChatUnit {
        
        let avatarUrl = idToAvatar[item.fromID] ?? nil

        let audioUnit = item.attachments[0].audio
        
        let audio = AudioChatMessage(url: URL(string: audioUnit?.url ?? "")!, duration: Float(audioUnit?.duration ?? 0), size: CGSize(width: 200, height: 100))

        return ChatUnit(sender: ChatUser(senderId: "\(item.fromID)", displayName: "", avatar: avatarUrl), messageId: "\(item.conversationMessageID)", sentDate: Date.init(timeIntervalSince1970: TimeInterval(item.date)), kind: MessageKind.audio(audio))
    }
    
    func convertVoiceMessage(_ item: ChatItem) -> ChatUnit {
        
        let avatarUrl = idToAvatar[item.fromID] ?? nil
        
        let audioUnit = item.attachments[0].audioMessage

        let audio = AudioChatMessage(url: URL(string: audioUnit?.link_mp3 ?? "")!, duration: Float(audioUnit?.duration ?? 0), size: CGSize(width: 200, height: 100))
        
        return ChatUnit(sender: ChatUser(senderId: "\(item.fromID)", displayName: "", avatar: avatarUrl), messageId: "\(item.conversationMessageID)", sentDate: Date.init(timeIntervalSince1970: TimeInterval(item.date)), kind: MessageKind.audio(audio))
    }
    
    func convertStickerMessage(_ item: ChatItem) -> ChatUnit {

        let avatarUrl = idToAvatar[item.fromID] ?? nil

        let stickerUnit = item.attachments[0].sticker

        let sticker = MediaChatMessage(url: URL(string: stickerUnit?.images[0].url ?? "")!, image: UIImage(), placeholderImage: UIImage(systemName: "rays")!, size: CGSize(width: stickerUnit?.images.last?.width ?? 0, height: stickerUnit?.images.last?.height ?? 0))

        return ChatUnit(sender: ChatUser(senderId: "\(item.fromID)", displayName: "", avatar: avatarUrl), messageId: "\(item.conversationMessageID)", sentDate: Date.init(timeIntervalSince1970: TimeInterval(item.date)), kind: MessageKind.photo(sticker))
    }

    func convertPhotoMessage(_ item: ChatItem) -> ChatUnit {

        let avatarUrl = idToAvatar[item.fromID] ?? nil

        let photoUnit = item.attachments[0].photo

        let photo = MediaChatMessage(url: URL(string: photoUnit?.sizes[0].url ?? "")!, image: UIImage(), placeholderImage: UIImage(systemName: "rays")!, size: CGSize(width: 300, height: photoUnit?.sizes.last?.height ?? 0))

        return ChatUnit(sender: ChatUser(senderId: "\(item.fromID)", displayName: "", avatar: avatarUrl), messageId: "\(item.conversationMessageID)", sentDate: Date.init(timeIntervalSince1970: TimeInterval(item.date)), kind: MessageKind.photo(photo))
    }
}
