//
//  DataMapper.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 16.03.2022.
//

import Foundation

class DataMapper {
    
    let defaultUser = TypeEnum.user
    let userApiInteractor: UsersApiInteractor = UsersApiInteracorImpl()
    
    func loadTableViewCellData(item: Item, completion: @escaping(TableViewCellData) -> Void) {
        let data = TableViewCellData()
        //print(item)
        if item.conversation.peer.type.rawValue == defaultUser.rawValue {
            userApiInteractor.getUserByID(userId: item.conversation.peer.id, completion: { result in
                data.title = result.firstName + " " + result.lastName
                data.lastMessage = item.lastMessage.text
                completion(data)
            })
        } else {
            data.title = item.conversation.chatSettings?.title ?? ""
            data.lastMessage = item.lastMessage.text
            completion(data)
        }
    }
}
