//
//  LockScreenFlowCoordinator.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 26.05.2022.
//

import Foundation
import UIKit

class LockScreenFlowCoordinator: FlowCoordinatorProtocol {
    
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
        let builder = LockModuleBuilder()
        return builder.build()
    }
    
}
