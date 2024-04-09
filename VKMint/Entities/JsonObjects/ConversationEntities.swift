//
//  Conversation.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 26.01.2022.
//

import Foundation

// MARK: - Conversation
struct Conversation: Codable {
    let unreadCount: Int?
    let count: Int
    let items: [Item]
    let profiles: [UserItems]

    enum CodingKeys: String, CodingKey {
        case unreadCount = "unread_count"
        case count, items, profiles
    }
}

// MARK: - Item
struct Item: Codable {
    let lastMessage: LastMessage
    let conversation: ConversationClass

    enum CodingKeys: String, CodingKey {
        case lastMessage = "last_message"
        case conversation
    }
}

// MARK: - ConversationClass
struct ConversationClass: Codable {
    let isMarkedUnread: Bool
    let inRead, lastConversationMessageID: Int // 1. id последнего прочитанного сообщения
    let peer: Peer // через эту фигнб можно понять с кем общаешься(беседа, лс ит.д)
    let canWrite: CanWrite // добавили ли тебя в чс
    let unreadCount: Int? // колл непрочитанных
    let lastMessageID, outRead, inReadCmid: Int
    let chatSettings: ChatSettings?
    let pushSettings: PushSettings?

    enum CodingKeys: String, CodingKey {
        case isMarkedUnread = "is_marked_unread"
        case inRead = "in_read"
        case lastConversationMessageID = "last_conversation_message_id"
        case peer
        case canWrite = "can_write"
        case unreadCount = "unread_count"
        case lastMessageID = "last_message_id"
        case outRead = "out_read"
        case inReadCmid = "in_read_cmid"
        case chatSettings = "chat_settings"
        case pushSettings = "push_settings"
    }
}

// MARK: - CanWrite
struct CanWrite: Codable {
    let allowed: Bool
}

// MARK: - ChatSettings
struct ChatSettings: Codable {
    let ownerID: Int
    let photo: Photo?
    let adminIDS: [Int]?
    let activeIDS: [Int]
    let membersCount: Int?
    let title: String

    enum CodingKeys: String, CodingKey {
        case ownerID = "owner_id"
        case photo = "photo"
        case adminIDS = "admin_ids"
        case activeIDS = "active_ids"
        case membersCount = "members_count"
        case title
    }
}

// MARK: - Photo
struct Photo: Codable {
    let photoMini: String?
    let isDefaultPhoto: Bool

    enum CodingKeys: String, CodingKey {
        case isDefaultPhoto = "is_default_photo"
        case photoMini = "photo_100"
    }
}

// MARK: - Permissions
struct Permissions: Codable {
    let invite: String

    enum CodingKeys: String, CodingKey {
        case invite
    }
}

// MARK: - Peer
struct Peer: Codable {
    let id, localID: Int
    let type: TypeEnum

    enum CodingKeys: String, CodingKey {
        case id
        case localID = "local_id"
        case type
    }
}

enum TypeEnum: String, Codable {
    case chat = "chat"
    case group = "group"
    case user = "user"
}

// MARK: - PushSettings
struct PushSettings: Codable {
    let disabledMassMentions, noSound, disabledForever, disabledMentions: Bool

    enum CodingKeys: String, CodingKey {
        case disabledMassMentions = "disabled_mass_mentions"
        case noSound = "no_sound"
        case disabledForever = "disabled_forever"
        case disabledMentions = "disabled_mentions"
    }
}

// MARK: - LastMessage
struct LastMessage: Codable {
    let peerID, id, date: Int
    let text: String

    enum CodingKeys: String, CodingKey {
        case peerID = "peer_id"
        case id = "id"
        case date = "date"
        case text = "text"
    }
}

struct Attachments: Codable {
    let type: String?

    enum CodingKeys: String, CodingKey {
        case type = "type"
    }
}

// MARK: - Encode/decode helpers
class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
