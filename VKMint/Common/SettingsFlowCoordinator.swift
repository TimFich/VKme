//
//  SettingsFlowCoordinator.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 16.05.2022.
//

import Foundation
import UIKit

protocol SettingsFlowCoordinatorOutput: AnyObject {
    func settingsWantsToClose()
}

class SettingsFlowCoordinator: FlowCoordinatorProtocol {

    private let parentViewController: UINavigationController?
    private let flag: Int
    private weak var output: SettingsFlowCoordinatorOutput?
    private var childCoordinators: [FlowCoordinatorProtocol] = []

    init(parentViewController: UINavigationController, flag: Int, output: SettingsFlowCoordinatorOutput) {
        self.parentViewController = parentViewController
        self.flag = flag
        self.output = output
    }

    func start(animated: Bool) {
        let vc = setUp(flag: flag)
        DispatchQueue.main.async {
            let backItem = UIBarButtonItem()
               backItem.title = "POPOPOP"
            vc.navigationItem.backBarButtonItem = backItem
            self.parentViewController?.pushViewController(vc, animated: true)
        }
    }

    func finish() {
        output?.settingsWantsToClose()
    }

    deinit {
        print("---Settings sdox")
    }

    private func setUp(flag: Int) -> UIViewController {
        if flag == 1 {
            let builder = AppearanceModuleBuilder(output: self)
            return builder.build()
        } else if flag == 2 {
            let builder = SecurityModuleBuilder(output: self)
                return builder.build()
        } else {
            let builder = AboutModuleBuilder(output: self)
            return builder.build()
        }
    }
}

extension SettingsFlowCoordinator: AppearanceModuleOutput {
    func appearenceWantsToClose() {
        finish()
    }
}

extension SettingsFlowCoordinator: SecurityModuleOutput {

    func openLockScreen() {
        let lockFC = LockFlowCoordinator(parentViewController: parentViewController!)
        childCoordinators.append(lockFC)
        lockFC.start(animated: true)
    }

    func securityWantsToClose() {
        finish()
    }
}

extension SettingsFlowCoordinator: AboutModuleOutput {
    func aboutWantsToClose() {
        finish()
    }
}
