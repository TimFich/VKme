//
//  UsersApiInteractor.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 18.04.2022.
//

import Foundation
import SwiftyVK

protocol UsersApiInteractor {
    func getUserByID(userId: Int, completion: @escaping (UserItems) -> ())
    func getUsers(ids: [Int], completion: @escaping ([UserItems]) -> Void)
}

class UsersApiInteracorImpl: UsersApiInteractor {
    
    func getUserByID(userId: Int, completion: @escaping (UserItems) -> ()) {
        print("2")
        print(userId)
        VK.API.Users.get([Parameter.userId: "\(userId)"])
            .onSuccess({ result in
                print(result)
                let user = try! JSONDecoder().decode([UserItems].self, from: result)
                print(user)
                    completion(user[0])
            }).send()
    }
    
    func getUsers(ids: [Int], completion: @escaping ([UserItems]) -> Void) {
        var parameters: Parameters = [:]
        for id in ids {
            parameters[Parameter.userId] = "\(id)"
        }
        VK.API.Users.get(parameters).onSuccess({ result in
            do {
                let users = try! JSONDecoder().decode([UserItems].self, from: result)
                DispatchQueue.main.async {
                    completion(users)
                }
            } catch let error {
                print(error)
            }
        }).send()
    }
    
}
