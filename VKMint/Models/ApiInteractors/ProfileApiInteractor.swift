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
    func getUserInfo(completion: @escaping ([UserItems: UIImage]) -> Void)
}

final class ProfileApiInteractorImpl: ProfileApiInteractor {

    private let downloader: ImageDownloader = ImageDownloaderImpl()

    func getUserInfo(completion: @escaping ([UserItems : UIImage]) -> Void) {
        VK.API.Users.get([Parameter.fields: "photo_200_orig, domain, contacts"])
            .onSuccess({
                let user = try! JSONDecoder().decode([UserItems].self, from: $0)
                self.downloader.downloadImage(urlOfPhoto: user[0].photo ?? "") {
                    var image: UIImage
                    image = $0
                    completion([user[0] : image])
                }
            }).send()
    }
}
