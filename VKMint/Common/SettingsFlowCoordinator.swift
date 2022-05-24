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
    
    init(parentViewController: UINavigationController, flag: Int) {
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
    
    private func setUp(flag: Int) -> UIViewController {
        if flag == 1 {
            let builder = AppearanceModuleBuilder()
            return builder.build()
        } else if flag == 2 {
            let builder = SecurityModuleBuilder()
            return builder.build()
        } else {
            let builder = AboutModuleBuilder()
            return builder.build()
        }
    }
    
}
