//
//  VKDelegate.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 20.01.2022.
//

import Foundation
import SwiftyVK

class VKDelegate: SwiftyVKDelegate {
    
    //MARK: - Properties
    let appId = "2685278"
    let scopes: Scopes = [.messages]
    var viewController: UIViewController?
    
    //MARK: - Public functions
    class func isAuthorised() -> Bool {
        return VK.sessions.default.accessToken != nil
        && VK.sessions.default.accessToken!.isValid
    }
    
    init() {
        VK.setUp(appId: appId, delegate: self)
    }
    
    func vkNeedsScopes(for sessionId: String) -> Scopes {
        return scopes
    }
    
    func vkNeedToPresent(viewController: VKViewController) {
        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
                        rootController.present(viewController, animated: true)
        }
    }
}
