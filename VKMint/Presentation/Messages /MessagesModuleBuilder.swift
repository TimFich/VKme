//
//  MessagesModuleBuilder.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 04.04.2022.
//

import Foundation
import UIKit

class MessagesModuleBuilder {
    
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


