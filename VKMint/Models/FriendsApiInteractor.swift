//
//  FriendsApiInteractor.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 28.04.2022.
//

import Foundation
import SwiftyVK

protocol FriendsApiInteractorProtocol {
    func getFriends(completion: @escaping (FriendEntity) -> ())
}

class FriendsApiInteractor: FriendsApiInteractorProtocol {
    
    func getFriends(completion: @escaping (FriendEntity) -> ()) {
        VK.API.Friends.get([Parameter.fields: "last_seen, photo_100,online", Parameter.order: "hints"]).onSuccess ({ result in
            do {
                let users = try! JSONDecoder().decode(FriendEntity.self, from: result)
                DispatchQueue.main.async {
                    completion(users)
                }
            } catch let error {
                print(error)
            }
        }).send()
    }
}
