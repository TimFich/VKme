//
//  FriendsApiInteractor.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 28.04.2022.
//

import Foundation
import SwiftyVK

protocol FriendsApiInteractor {
    func getFriends(completion: @escaping (UserEntities) -> ())
}

class FriendsApiInteractorImpl: FriendsApiInteractor {
    
    func getFriends(completion: @escaping (UserEntities) -> ()) {
        VK.API.Friends.get([Parameter.fields: "photo_200_orig"]).onSuccess ({ result in
            do {
                let users = try! JSONDecoder().decode(UserEntities.self, from: result)
                DispatchQueue.main.async {
                    completion(users)
                }
            } catch let error {
                print(error)
            }
        }).send()
    }
}
