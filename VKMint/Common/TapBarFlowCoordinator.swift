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
        setUp()
        parentViewController?.pushViewController(tapBar, animated: true)
    }
    
    func finish(animated: Bool) {
    }
    
    private func setUp() {
        let messagesVC = buildMessages()
        messagesVC.tabBarItem = UITabBarItem(title: "Messages", image: nil, tag: 1)
        tapBar.addChild(messagesVC)
    }
    
    private func buildMessages() -> UIViewController {
        let builder = MessagesModuleBuilder()
        return builder.build()
    }
    
    private func buildFriends() -> UIViewController {
        return UIViewController()
    }
    
    private func buildSettings() -> UIViewController {
        return UIViewController()
    }
}
