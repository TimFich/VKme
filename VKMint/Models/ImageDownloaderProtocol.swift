//
//  ImageDownloader.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 18.04.2022.
//

import Foundation
import SwiftyVK

protocol ImageDownloaderProtocol {
    func getUserAvatar(userId: Int, completion: @escaping ([UserEntities]) -> Void)
    func downloadImage(urlOfPhoto: String, completion: @escaping ((UIImage) -> ()))
}

class ImageDownloader: ImageDownloaderProtocol {
    
    func getUserAvatar(userId: Int, completion: @escaping ([UserEntities]) -> Void) {
        VK.API.Users.get([Parameter.userId: "\(userId)", Parameter.fields: "photo_200"]).onSuccess ({ result in
            
            let users = try! JSONDecoder().decode([UserEntities].self, from: result)
            
            DispatchQueue.main.async {
                print("--loaded")
                completion(users)
            }
        }).onError ({_ in
           print("--error")
        }).send()
    }
    
    func downloadImage(urlOfPhoto: String, completion: @escaping((UIImage) -> ())) {
        let url = URL(string: "\(urlOfPhoto)")
                
        getData(from: url!) { data, response, error in
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
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
