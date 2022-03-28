//
//  APIInteractor.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 20.01.2022.
//

import Foundation
import SwiftyVK
import UIKit

class APIInteractor {
    
    //MARK: - Public functions
    class func authorize(onSuccess: @escaping () -> (), onError: @escaping () -> ()) {
        VK.sessions.default.logIn(onSuccess: {
            _ in
            onSuccess()
        }, onError: {
            _ in
            onError()
        })
    }
    
    class func getConversation(completion: @escaping (Conversation) -> ()) {
        VK.API.Messages.getConversations(.empty)
            .onSuccess({ result in
                do {
                    let conversation = try? JSONDecoder().decode(Conversation.self, from: result)
                    DispatchQueue.main.async {
                        completion(conversation!)
                    }
                } catch let error {
                    print(error)
                }
            }).send()
    }
    
    //MARK: - Get User by ID
    static func getUserByID(userId: Int, completion: @escaping (UserEntities) -> ()) {
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
    
    static func getUsers(ids: [Int], completion: @escaping ([UserEntities]) -> Void) {
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
    
    static func getUserAvatar(userId: Int, completion: @escaping ([UserEntities]) -> Void) {
        VK.API.Users.get([Parameter.userId: "\(userId)", Parameter.fields: "photo_200"]).onSuccess ({ result in
            
            let users = try! JSONDecoder().decode([UserEntities].self, from: result)
            
            DispatchQueue.main.async {
                completion(users)
            }
       }).send()
    }
    
    static func downloadImage(urlOfPhoto: String, completion: @escaping((UIImage) -> ())) {
        let url = URL(string: "\(urlOfPhoto)")
                
        getData(from: url!) { data, response, error in
//            print(response?.suggestedFilename ?? url?.lastPathComponent as Any)
            guard let data = data, error == nil else { return }
            guard let image: UIImage = UIImage(data: data) else {
                print("Invalid image data")
                return
            }
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
