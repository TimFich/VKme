//
//  ContactsInteractor.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 09.05.2022.
//

import Foundation

protocol ContactsInteractorInput: AnyObject {
    func fetchUsers(completion: @escaping ([ContactsTableViewCellData]) -> Void)
}

protocol ContactsInteractorOutput: AnyObject {
    func needToUpdateContacts(updatedData: [ContactsTableViewCellData])
    func startUpdatingUsers()
    func endUpdatingUsers()
}

class СontactsInteractor {
    
    //MARK: - Properties
    let friendsApiInteractor: FriendsApiInteractorProtocol = FriendsApiInteractor()
    let dataStoreManager: DataStoreManagerProtocol = DataStoreManager()
    weak var output: ContactsInteractorOutput!
}

extension СontactsInteractor: ContactsInteractorInput {
    func fetchUsers(completion: @escaping ([ContactsTableViewCellData]) -> Void) {
        let converter = ContactsTableViewCellConverter()
        let cdResult = dataStoreManager.fetchContacts()
        if cdResult.isEmpty {
            output.startUpdatingUsers()
            friendsApiInteractor.getFriends(completion: { userEntities in
                converter.convertToCellData(contacts: userEntities, completion: { result in
                    completion(result)
                    self.output.endUpdatingUsers()
                    self.dataStoreManager.addContacts(contacts: userEntities)
                })
            })
        } else {
            let cellData = converter.convertToCellData(contacts: cdResult)
            completion(cellData)
            output.startUpdatingUsers()
            friendsApiInteractor.getFriends(completion: { userEntities in
                converter.convertToCellData(contacts: userEntities, completion: {
                    result in
                    self.output.needToUpdateContacts(updatedData: result)
                    self.output.endUpdatingUsers()
                })
                self.dataStoreManager.addContacts(contacts: userEntities)
            })
        }
    }
}


