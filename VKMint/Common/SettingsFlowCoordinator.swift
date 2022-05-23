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
    private let flag: Bool
    
    init(parentViewController: UINavigationController, flag: Bool) {
        self.parentViewController = parentViewController
        self.flag = flag
    }
    
    func start(animated: Bool) {
        let vc = setUp(flag: flag)
        DispatchQueue.main.async {
            self.parentViewController?.pushViewController(vc, animated: true)
        }
    }
    
    func finish(animated: Bool) {
    }
    
    private func setUp(flag: Bool) -> UIViewController {
        if flag {
            let builder = AppearanceModuleBuilder()
            return builder.build()
        } else {
            let builder = AboutModuleBuilder()
            return builder.build()
        }
    }
    
}
