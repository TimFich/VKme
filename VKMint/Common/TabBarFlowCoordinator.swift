//
//  TapBarFlowCoordinator.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 28.04.2022.
//

import Foundation
import UIKit

class TabBarFlowCoordinator: FlowCoordinatorProtocol {
    
    
    private let tabBar = UITabBarController()
    private let parentViewController: UINavigationController?
    
    
    init(parentViewController: UINavigationController) {
        self.parentViewController = parentViewController
    }
    
    func start(animated: Bool) {
        setUp()
        parentViewController?.pushViewController(tabBar, animated: true)
    }
    
    func finish(animated: Bool) {
    }
    
    private func setUp() {
        let contactsVC = buildContacts()
        
        let messagesVC = buildMessages()
        
        let profileVC = buildProfile()
        
        contactsVC.tabBarItem = UITabBarItem(title: "Contacts", image: UIImage(systemName: "person.2.fill"), tag: 0)
        tabBar.addChild(contactsVC)
        
        messagesVC.tabBarItem = UITabBarItem(title: "Messages", image: UIImage(systemName: "message.fill"), tag: 1)
        tabBar.addChild(messagesVC)
        
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 2)
        tabBar.addChild(profileVC)

    }
    
    private func buildMessages() -> UIViewController {
        let builder = MessagesModuleBuilder()
        return builder.build()
    }
    
    private func buildContacts() -> UIViewController {
        let builder = ContactsModuleBuilder()
        return builder.build()
    }
    
    private func buildProfile() -> UIViewController {
        let builder = ProfileModuleBuilder()
        return builder.build()
    }
}
