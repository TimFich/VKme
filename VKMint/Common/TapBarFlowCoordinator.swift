//
//  TapBarFlowCoordinator.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 28.04.2022.
//

import Foundation
import UIKit

class TapBarFlowCoordinator: FlowCoordinatorProtocol {
    
    private let tapBar = UITabBarController()
    private let parentViewController: UINavigationController?
    
    
    init(parentViewController: UINavigationController) {
        self.parentViewController = parentViewController
    }
    
    func start(animated: Bool) {
    
        parentViewController?.pushViewController(tapBar, animated: true)
    }
    
    func finish(animated: Bool) {
    }
    
    private func setUp() {
        
    }
    
    private func buildMessages() -> UIViewController {
        return UIViewController()
    }
    
    private func buildFriends() -> UIViewController {
        return UIViewController()
    }
    
    private func buildSettings() -> UIViewController {
        return UIViewController()
    }
}
