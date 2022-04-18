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
    public weak var parentViewController: UIViewController?
    private var childCoordinators: [FlowCoordinatorProtocol] = []
    

    init(parentViewController: UIViewController?, finishHandler: @escaping () -> Void) {
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
        parentViewController?.presentedViewController?.dismiss(animated: animated, completion: finishHandler)
    }
    
    private func openMessages(animated: Bool) {
        //TODO: Made messages module
    }
    
    private func openAuth(animated: Bool) {
        let builder = AuthorisationModuleBuilder(output: self)
        let viewController = builder.build()
        parentViewController?.present(viewController, animated: animated, completion: nil)
    }
}

extension MainFlowCoordinator: AuthModuleOutput {
    func moduleWantsToOpenMessages(animated: Bool) {
        openMessages(animated: animated)
    }
}
