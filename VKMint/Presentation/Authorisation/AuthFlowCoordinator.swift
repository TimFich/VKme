//
//  AuthFlowCoordinator.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 08.04.2022.
//

import Foundation
import UIKit

class MainFlowCoordinator: FlowCoordinatorProtocol {

    private var finishHandler: () -> Void
    public weak var parentViewController: UINavigationController?
    private var childCoordinators: [FlowCoordinatorProtocol] = []

    init(parentViewController: UINavigationController?, finishHandler: @escaping () -> Void) {
        self.parentViewController = parentViewController
        self.finishHandler = finishHandler
    }

    func start(animated: Bool) {
        if VKDelegate.isAuthorised() {
            openMessages(animated: animated)
        } else {
            openAuth(animated: animated)
        }
    }

    func finish(animated: Bool) {
    }

    private func openAuth(animated: Bool) {
        let builder = AuthorisationModuleBuilder(output: self)
        let viewController = builder.build()
        viewController.modalPresentationStyle = .fullScreen
        parentViewController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - AuthModuleOutput
extension MainFlowCoordinator: AuthModuleOutput {
    func moduleWantsToOpenMessages(animated: Bool) {
        openMessages(animated: animated)
    }
}
