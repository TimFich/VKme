//
//  AuthFlowCoordinator.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 08.04.2022.
//

import Foundation
import UIKit

class MainFlowCoordinator: FlowCoordinatorProtocol {
    
    //MARK: - Properties
    private var finishHandler: () -> Void
    public weak var parentViewController: UINavigationController?
    private var childCoordinators: [FlowCoordinatorProtocol] = []
    
    init(parentViewController: UINavigationController?, finishHandler: @escaping () -> Void) {
        self.parentViewController = parentViewController
        self.finishHandler = finishHandler
    }
    
    func start(animated: Bool) {
        if VKDelegate.isAuthorised() {
            openTabBar(animated: animated)
        } else {
            openAuth(animated: animated, completion: nil)
        }
    }
    
    func finish() {
        // unused
    }
    
    private func openTabBar(animated: Bool) {
        let tabBarFC = TabBarFlowCoordinator(parentViewController: parentViewController!, output: self)
        childCoordinators.append(tabBarFC)
        tabBarFC.start(animated: true)
    }
    
    func openAuth(animated: Bool, completion: (() -> Void)?) {
        let builder = AuthorisationModuleBuilder(output: self)
        let viewController = builder.build()
        viewController.modalPresentationStyle = .fullScreen
        parentViewController?.pushViewController(viewController, animated: true)
        completion?()
    }
    
    deinit {
        print("---Main sdox")
    }
}

//MARK: - AuthModuleOutput
extension MainFlowCoordinator: AuthModuleOutput {
    func moduleWantsToOpenTapBar(animated: Bool) {
        openTabBar(animated: animated)
    }
}

extension MainFlowCoordinator: TabBarFlowCoordinatorOutput {
    func tabBarWantsToClose(completion: () -> Void) {
        childCoordinators.removeAll(where: { coordinator in
            coordinator is TabBarFlowCoordinator
        })
        completion()
    }
    
    func tabBarWantsToOpenAuth() {
        openAuth(animated: true, completion: nil)
    }
}
