//
//  SettingsFlowCoordinator.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 16.05.2022.
//

import Foundation
import UIKit

class SettingsFlowCoordinator: FlowCoordinatorProtocol {
    
    private let parentViewController: UINavigationController?
    private let flag: Int
    private var door = false
    private let keyChainManager = KeychainManager()
    private var isExistPassword = false
    
    init(parentViewController: UINavigationController, flag: Int, door: Bool) {
        self.parentViewController = parentViewController
        self.flag = flag
        self.door = door
        isExistPassword = keyChainManager.isExist()
    }
    
    func start(animated: Bool) {
        let vc = setUp(flag: flag)
        DispatchQueue.main.async {
            self.parentViewController?.pushViewController(vc, animated: true)
        }
    }
    
    func finish(animated: Bool) {
    }
    
    private func setUp(flag: Int) -> UIViewController {
        if flag == 1 {
            let builder = AppearanceModuleBuilder()
            return builder.build()
        } else if flag == 2 {
            if !isExistPassword || door {
                print("Open Security screen")
                let builder = SecurityModuleBuilder()
                return builder.build()
            } else {
                print("Open Lock screen")
                let builder = LockModuleBuilder()
                return builder.build()
            }
        } else {
            let builder = AboutModuleBuilder()
            return builder.build()
        }
    }
    
}
