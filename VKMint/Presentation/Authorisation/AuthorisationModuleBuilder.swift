//
//  AuthorisationModuleBuilder.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 04.04.2022.
//

import Foundation
import UIKit

protocol AuthModuleOutput: AnyObject {
    func moduleWantsToOpenTapBar(animated: Bool)
}

class AuthorisationModuleBuilder {
    
    private weak var output: AuthModuleOutput?
    
    init(output: AuthModuleOutput) {
        self.output = output
    }
    
    func build() -> UIViewController {
        let interactor = AuthInteractor()
        let presenter = AuthPresenter(interactor: interactor, moduleOutput: output!)
        let vc = AuthViewController()
        vc.presenter = presenter
        interactor.output = presenter
        presenter.view = vc
        return vc
    }
}
