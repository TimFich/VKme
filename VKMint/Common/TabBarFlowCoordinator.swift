//
//  TapBarFlowCoordinator.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 28.04.2022.
//

import Foundation
import UIKit

protocol TabBarFlowCoordinatorOutput: AnyObject {
    func tabBarWantsToClose(completion: () -> Void)
    func tabBarWantsToOpenAuth()
}

class TabBarFlowCoordinator: FlowCoordinatorProtocol {
    
    
    private let tabBar = UITabBarController()
    private weak var output: TabBarFlowCoordinatorOutput?
    private let parentViewController: UINavigationController?
    private var childCoordinators: [FlowCoordinatorProtocol] = []
    
    
    init(parentViewController: UINavigationController, output: TabBarFlowCoordinatorOutput) {
        self.parentViewController = parentViewController
        self.output = output
    }
    
    func start(animated: Bool) {
        setUp()
        parentViewController?.pushViewController(tabBar, animated: true)
    }
    
    func finish(animated: Bool, completion: () -> Void) {
        output?.tabBarWantsToClose(completion: completion)
    }
    
    func finish() {
        // unused
    }
    
    deinit {
        print("---TabBar sdox")
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
        let builder = MessagesModuleBuilder(output: self)
        return builder.build()
    }
    
    private func buildContacts() -> UIViewController {
        let builder = ContactsModuleBuilder()
        return builder.build()
    }
    
    private func buildProfile() -> UIViewController {
        let builder = ProfileModuleBuilder(output: self)
        return builder.build()
    }
}

extension TabBarFlowCoordinator: ProfileModuleOutput {
    func moduleWantsToOpenSetting(flag: Int) {
        let setFC = SettingsFlowCoordinator(parentViewController: parentViewController!, flag: flag, output: self)
        childCoordinators.append(setFC)
        setFC.start(animated: true)
    }
    
    func moduleWantsToOpenAuthScreen() {
        finish(animated: true, completion: {
            output?.tabBarWantsToOpenAuth()
        })
    }
}

extension TabBarFlowCoordinator: MessagesModuleOutput {
    
    func openChat(id: Int, title: String) {
        let vc = ChatModuleBuilder(id: id, title: title).build()
        let backItem = UIBarButtonItem()
            backItem.title = "Back"
        vc.navigationItem.backBarButtonItem = backItem
        parentViewController?.pushViewController(vc, animated: true)
    }
}

extension TabBarFlowCoordinator: SettingsFlowCoordinatorOutput {
    func settingsWantsToClose() {
        childCoordinators.removeAll(where: { coordinator in
            coordinator is SettingsFlowCoordinator
        })
    }
}
