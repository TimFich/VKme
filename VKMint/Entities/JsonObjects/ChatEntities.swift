//
//  ChatEntities.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 30.05.2022.
//

import Foundation

// MARK: - Response
struct ChatResponse: Codable {
    let count: Int
    let items: [ChatItem]
}

// MARK: - Item
struct ChatItem: Codable {
    let date, fromID, id, out: Int
    let conversationMessageID: Int
    let attachments: [ChatAttachments]
    let important, isHidden: Bool
    let peerID, randomID: Int
    let text: String
    let ref: String?

    enum CodingKeys: String, CodingKey {
        case date
        case fromID = "from_id"
        case id, out, attachments
        case conversationMessageID = "conversation_message_id"
        case important
        case isHidden = "is_hidden"
        case peerID = "peer_id"
        case randomID = "random_id"
        case text, ref
    }
}

//MARK: - ChatAttachments
struct ChatAttachments: Codable {
    let type: String
    let photo: ChatPhoto?
    let sticker: Stickers?
    let audio: Audio?
    let audioMessage: AudioMessage?
    
    enum CodingKeys: String, CodingKey {
        case type
        case photo
        case sticker
        case audio
        case audioMessage = "audio_message"
    }
}

//MARK: - ChatPhoto
struct ChatPhoto: Codable {
    let id: Int
    let date: Int
    let ownerId: Int
    let accessKey: String
    let sizes: [PhotoSizes]
    
    enum CodingKeys: String, CodingKey {
        case id, date
        case ownerId = "owner_id"
        case accessKey = "access_key"
        case sizes
    }
}

//MARK: - PhotoSizes
struct PhotoSizes: Codable {
    let height: Int
    let url: String
}

//MARK: - Stickers
struct Stickers: Codable {
    let stickerId: Int
    let images: [StickerSizes]
    
    enum CodingKeys: String, CodingKey {
        case stickerId = "sticker_id"
        case images
    }
}

//MARK: - StickerSizes
struct StickerSizes: Codable {
    let url: String
    let width: Int
    let height: Int
}

//MARK: - AudioMessage
struct Audio: Codable {
    let artist: String
    let title: String
    let duration: Int
    let url: String
}

struct AudioMessage: Codable {
    let id: Int
    let duration: Int
    let link_mp3: String
}

