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
        let contactsVC = buildContacts()
        
        let messagesVC = buildMessages()
        messagesVC.tabBarItem = UITabBarItem(title: "Messages", image: UIImage(systemName: "message.fill"), tag: 1)
        tapBar.addChild(messagesVC)
        
        contactsVC.tabBarItem = UITabBarItem(title: "Contacts", image: UIImage(systemName: "person.2.fill")!, tag: 0)
        tapBar.addChild(contactsVC)

    }
    
    private func buildMessages() -> UIViewController {
        let builder = MessagesModuleBuilder()
        return builder.build()
    }
    
    private func buildContacts() -> UIViewController {
        let builder = ContactsModuleBuilder()
        return builder.build()
    }
    
    private func buildSettings() -> UIViewController {
        return UIViewController()
    }
}
