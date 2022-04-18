//
//  UsersApiInteractor.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 18.04.2022.
//

import Foundation
import SwiftyVK

protocol UsersApiInteractor {
    func getUserByID(userId: Int, completion: @escaping (UserEntities) -> ())
    func getUsers(ids: [Int], completion: @escaping ([UserEntities]) -> Void)
}

class UsersApiInteracorImpl: UsersApiInteractor {
    
    func getUserByID(userId: Int, completion: @escaping (UserEntities) -> ()) {
        VK.API.Users.get([Parameter.userId: "\(userId)"])
            .onSuccess({ result in
                do {
                    let user = try! JSONDecoder().decode([UserEntities].self, from: result)
                    if user != nil {
                        DispatchQueue.main.async {
                            completion(user[0])
                        }
                    }
                } catch let error {
                    print(error)
                }
            }).send()
    }
    
    func getUsers(ids: [Int], completion: @escaping ([UserEntities]) -> Void) {
        var parameters: Parameters = [:]
        for id in ids {
            parameters[Parameter.userId] = "\(id)"
        }
        VK.API.Users.get(parameters).onSuccess({ result in
            do {
                let users = try! JSONDecoder().decode([UserEntities].self, from: result)
                DispatchQueue.main.async {
                    completion(users)
                }
            } catch let error {
                print(error)
            }
        }).send()
    }
    
}
