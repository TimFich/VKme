//
//  ProfileApiInteractor.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 10.05.2022.
//

import Foundation
import SwiftyVK
import UIKit

protocol ProfileApiInteractor {
    func getUserInfo(completion: @escaping ([UserItems: UIImage]) -> ())
}

class ProfileApiInteractorImpl: ProfileApiInteractor {
    
    private let downloader: ImageDownloader = ImageDownloaderImpl()
    
    func getUserInfo(completion: @escaping ([UserItems : UIImage]) -> ()) {
        VK.API.Users.get([Parameter.fields: "photo_200_orig, domain, contacts"]).onSuccess ({ result in
            let user = try! JSONDecoder().decode([UserItems].self, from: result)
            self.downloader.downloadImage(urlOfPhoto: user[0].photo ?? "") { result in
                var image: UIImage
                image = result
                completion([user[0] : image])
            }
        }).send()
    }
}
