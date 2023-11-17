//
//  ProfileInteractor.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 10.05.2022.
//

import Foundation
import UIKit

protocol ProfileInteractorInput: AnyObject {
    func getDataOfUser(completion: @escaping (ProfileData) -> Void)
    func logout()
}

protocol ProfileInteractorOutput: AnyObject {
    func logoutSuccess()
}

class ProfileInteractor {
    private let profileInteractor: ProfileApiInteractor = ProfileApiInteractorImpl()
    private let downloader: ImageDownloader = ImageDownloaderImpl()
    private let mainInteractor: MainApiInteractor = MainApiInteractorImpl()
    weak var output: ProfileInteractorOutput!
}

// MARK: - ProfileInteractorInput

extension ProfileInteractor: ProfileInteractorInput {

    func getDataOfUser(completion: @escaping (ProfileData) -> Void) {
        let converter = ProfileDataConverter()
        profileInteractor.getUserInfo { result in
            converter.convertToData(photoUser: result) { res in
                completion(res)
            }
        }
    }

    func logout() {
        mainInteractor.sigout()
        output.logoutSuccess()
    }
}
