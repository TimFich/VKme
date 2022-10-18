//
//  UsersApiInteractor.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 18.04.2022.
//

import Foundation
import SwiftyVK

protocol UsersApiInteractor {
    func getUserByID(userId: Int, completion: @escaping (UserItems) -> Void)
    func getUsers(ids: [Int], completion: @escaping ([UserItems]) -> Void)
}

final class UsersApiInteracorImpl: UsersApiInteractor {

    func getUserByID(userId: Int, completion: @escaping (UserItems) -> Void) {
        VK.API.Users.get([Parameter.userId: "\(userId)"])
            .onSuccess({ result in
                let user = try! JSONDecoder().decode([UserItems].self, from: result)
                    completion(user[0])
            }).send()
    }

    func getUsers(ids: [Int], completion: @escaping ([UserItems]) -> Void) {
        var parameters: Parameters = [:]
        for id in ids {
            parameters[Parameter.userId] = "\(id)"
        }
        VK.API.Users.get(parameters).onSuccess({ result in

                let users = try! JSONDecoder().decode([UserItems].self, from: result)
                DispatchQueue.main.async {
                    completion(users)
                }
        }).send()
    }
}
