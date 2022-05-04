//
//  DataStoreManager.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 27.04.2022.
//

import Foundation
import CoreData

protocol DataStoreManagerProtocol {
    func saveContext()
    func fetchConversations() -> CDConversations?
    func addCDConversation(_ conversation: Conversation)
}

class DataStoreManager: DataStoreManagerProtocol {
    
    lazy var viewContext = persistentContainer.viewContext
    let imageDownloader: ImageDownloaderProtocol = ImageDownloader()
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Entities for messages")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - CRUD
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchConversations() -> CDConversations? {
        let fetchRequest = CDConversations.fetchRequest()
        do {
            let result = try persistentContainer.viewContext.fetch(fetchRequest)
            return result.first
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func addCDConversation(_ conversation: Conversation) {
        let cdConv = CDConversations(context: viewContext)
        cdConv.count = Int64(conversation.count)
        cdConv.unreadCount = Int64(conversation.unreadCount ?? 0)
        cdConv.items = tranformItemsToSet(conversation.items)
        cdConv.profiles = transformProfilesToSet(conversation.profiles)
    }
    
    func tranformItemsToSet(_ items: [Item]) -> Set<CDItems> {
        var cdItems: [CDItems] = []
        for item in items {
            cdItems.append(addCDItem(item))
        }
        return Set(cdItems)
    }
    
    func transformProfilesToSet(_ profiles: [UserItems]) -> Set<CDUserItems> {
        var cdProfiles: [CDUserItems] = []
        for profile in profiles {
            cdProfiles.append(addCDUserItem(profile))
        }
        return Set(cdProfiles)
    }
    
    func addCDItem(_ item: Item) -> CDItems {
        let cdItem = CDItems(context: viewContext)
        cdItem.conversation = addCDConversationClass(item.conversation)
        cdItem.lastMessage = addCDLastMessages(item.lastMessage)
        saveContext()
        return cdItem
    }
    
    func addCDUserItem(_ profile: UserItems) -> CDUserItems {
        let cdProfile = CDUserItems(context: viewContext)
        cdProfile.firstName = profile.firstName
        cdProfile.lastName = profile.lastName
        cdProfile.id = Int64(profile.id)
        guard let photoReference = profile.photo else {
            saveContext()
            return cdProfile
        }
        imageDownloader.downloadImage(urlOfPhoto: photoReference, completion: { [self] image in
            cdProfile.photo = NSData.init(data: image.pngData()!)
            saveContext()
        })
        return cdProfile
    }
    
    func addCDConversationClass(_ conversation: ConversationClass) -> CDConversationClass {
        let convClass = CDConversationClass(context: viewContext)
        convClass.unreadCount = Int64(conversation.unreadCount ?? 0)
        convClass.isMarkedUnread = conversation.isMarkedUnread
        convClass.peer = addCDPeer(conversation.peer)
        if conversation.chatSettings != nil {
        convClass.chatSettings = addCDChatSettings(conversation.chatSettings!)
        }
        saveContext()
        return convClass
    }
    
    func addCDPeer(_ peer: Peer) -> CDPeer {
        let cdPeer = CDPeer(context: viewContext)
        cdPeer.id = Int64(peer.id)
        cdPeer.type = peer.type.rawValue
        saveContext()
        return cdPeer
    }
    
    func addCDChatSettings(_ chatSet: ChatSettings) -> CDChatSettings {
        let cdChatSet = CDChatSettings(context: viewContext)
        cdChatSet.ownerID = Int64(chatSet.ownerID)
        cdChatSet.membersCount = Int64(chatSet.membersCount ?? 0)
        cdChatSet.title = chatSet.title
        guard let photoReference = chatSet.photo?.photoMini else {
            saveContext()
            return cdChatSet
        }
        imageDownloader.downloadImage(urlOfPhoto: photoReference, completion: { [self] image in
            cdChatSet.photo = NSData(data: image.pngData()!)
            saveContext()
        })
        return cdChatSet
    }
    
    func addCDLastMessages(_ lastMessage: LastMessage) -> CDLastMessage {
        let cdLastMess = CDLastMessage(context: viewContext)
        cdLastMess.id = Int64(lastMessage.id)
        cdLastMess.fromID = Int64(lastMessage.fromID)
        cdLastMess.peerID = Int64(lastMessage.peerID)
        cdLastMess.text = lastMessage.text
        cdLastMess.isHidden = lastMessage.isHidden
        cdLastMess.conversationMessageID = Int64(lastMessage.conversationMessageID)
        cdLastMess.date = Date(timeIntervalSince1970: TimeInterval(lastMessage.date))
        saveContext()
        return cdLastMess
    }
}
