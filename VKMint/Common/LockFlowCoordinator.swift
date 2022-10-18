//
//  LockScreenFlowCoordinator.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 26.05.2022.
//

import Foundation
import UIKit

final class LockFlowCoordinator: FlowCoordinatorProtocol {

    private let parentViewController: UINavigationController?

    init(parentViewController: UINavigationController) {
        self.parentViewController = parentViewController
    }

    func start(animated: Bool) {
        let vc = setUp()
        vc.modalPresentationStyle = .fullScreen
        parentViewController?.present(vc, animated: true)
    }

    func finish() {
    }

    private func setUp() -> UIViewController {
        let builder = LockModuleBuilder()
        return builder.build()
    }
}
