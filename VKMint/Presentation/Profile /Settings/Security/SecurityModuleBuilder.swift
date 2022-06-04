//
//  SecurityModuleBuilder.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 24.05.2022.
//

import Foundation
import UIKit

protocol SecurityModuleOutput: AnyObject {
    func securityWantsToClose()
    func openLockScreen()
}

class SecurityModuleBuilder {

    private weak var output: SecurityModuleOutput?

    init(output: SecurityModuleOutput) {
        self.output = output
    }

    func build() -> UIViewController {
        let interactor = SecurityInteractor()
        let view = SecurityViewController()
        let presenter = SecurityPresenter(interactor: interactor, view: view, output: output!)
        interactor.output = presenter
        view.presenter = presenter
        return view
    }
}
