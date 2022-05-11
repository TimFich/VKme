//
//  ProfileInteractor.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 10.05.2022.
//

import Foundation

protocol ProfileInteractorInput: AnyObject {
    func getDataOfUser(completion: @escaping (ProfileData) -> Void)
}

protocol ProfileInteractorOutput: AnyObject {
    
}

class ProfileInteractor {
    private let profileInteractor: ProfileApiInteractor = ProfileApiInteractorImpl()
    private let downloader: ImageDownloader = ImageDownloaderImpl()
    weak var output: ProfileInteractorOutput!
}

//MARK: - ProfileInteractorInput
extension ProfileInteractor: ProfileInteractorInput {
    func getDataOfUser(completion: @escaping (ProfileData) -> Void) {
        let converter = ProfileDataConverter()
        profileInteractor.getUserInfo { result in
            converter.convertToData(photoUser: result) { res in
                completion(res)
            }
        }
    }
}
