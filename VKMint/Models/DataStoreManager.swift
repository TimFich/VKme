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
    func deleteConversations()
    func replaceLastMessage(lastMessage: LastMessage)
    func fetchContacts() -> [CDContacts]
    func addContacts(contacts: FriendEntity)
}

class DataStoreManager: DataStoreManagerProtocol {
    
    lazy var viewContext = persistentContainer.viewContext
    let imageDownloader: ImageDownloader = ImageDownloaderImpl()

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
    
    func deleteConversations() {
        let fetchRequest = CDConversations.fetchRequest()
        do {
            let results = try persistentContainer.viewContext.fetch(fetchRequest)
            for model in results {
                viewContext.delete(model)
            }
            saveContext()
        } catch {
            
        }
    }
    
    func fetchContacts() -> [CDContacts] {
        let fetchRequest = CDContacts.fetchRequest()
        do {
            let result = try persistentContainer.viewContext.fetch(fetchRequest)
            return result
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func addContacts(contacts: FriendEntity) {
        let fetchRequest = CDContacts.fetchRequest()
        do {
            let results = try persistentContainer.viewContext.fetch(fetchRequest)
            for result in results {
                viewContext.delete(result)
            }
            for contact in contacts.items {
                if contact.deactivated != nil {
                    continue
                }
                let cdContact = CDContacts(context: viewContext)
                let isOnline = contact.online == 1 ? true : false
                cdContact.id = Int64(contact.id)
                cdContact.firstName = contact.firstName
                cdContact.lastName = contact.lastName
                cdContact.isOnline = isOnline
                cdContact.platform = Int64(contact.lastSeen?.platform ?? 0)
                cdContact.lastSeen = Int64(contact.lastSeen?.time ?? 0)
                imageDownloader.downloadImage(urlOfPhoto: contact.photo100, completion: { image in
                    cdContact.photo = NSData.init(data: image.pngData()!)
                    self.saveContext()
                })
                saveContext()
            }
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
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
    
    func tranformItemsToSet(_ items: [Item]) -> NSOrderedSet {
        var cdItems: [CDItems] = []
        for item in items {
            cdItems.append(addCDItem(item))
        }
        return NSOrderedSet(array: cdItems)
    }
    
    func transformProfilesToSet(_ profiles: [UserItems]) -> NSOrderedSet {
        var cdProfiles: [CDUserItems] = []
        for profile in profiles {
            cdProfiles.append(addCDUserItem(profile))
        }
        return NSOrderedSet(array: cdProfiles)
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
        imageDownloader.downloadImage(urlOfPhoto: profile.photo_100!, completion: { [self] image in
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
        cdLastMess.peerID = Int64(lastMessage.peerID)
        cdLastMess.text = lastMessage.text
        cdLastMess.date = Date(timeIntervalSince1970: TimeInterval(lastMessage.date))
        saveContext()
        return cdLastMess
    }

    func replaceLastMessage(lastMessage: LastMessage) {
        let fetchRequest = CDLastMessage.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "peerID == %@", NSNumber(value: lastMessage.peerID))
        do {
            let results = try persistentContainer.viewContext.fetch(fetchRequest)
            for result in results {
                result.date =  Date(timeIntervalSince1970: TimeInterval(lastMessage.date))
                result.text = lastMessage.text
                result.id = Int64(lastMessage.id)
            }
            saveContext()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
