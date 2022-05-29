//
//  ProfileDataConverter.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 10.05.2022.
//

import Foundation
import UIKit

class ProfileDataConverter {
    
    //MARK: - Private properties
    private let profileApiInteractor: ProfileApiInteractor = ProfileApiInteractorImpl()
    
    func convertToData(photoUser: [UserItems : UIImage], completion: @escaping (ProfileData) -> Void) {
        
        let images = photoUser.values
        let users = photoUser.keys
        let user = users.first
        let image = images.first
        var newDomain = ""
        
        if user?.domain == "" {
             newDomain = "\(user?.id)"
        } else {
            newDomain = user!.domain ?? ""
        }
        
        completion(ProfileData(firstName: user!.firstName, lastName: user!.lastName, photo: image ?? UIImage(), number: user!.phoneNumber, nickname: user?.domain))
    }
}
