//
//  SecurityModuleBuilder.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 24.05.2022.
//

import Foundation
import UIKit

class SecurityModuleBuilder {
    
    func build() -> UIViewController {
        let interactor = SecurityInteractor()
        let view = SecurityViewController()
        let presenter = SecurityPresenter(interactor: interactor, view: view)
        interactor.output = presenter
        view.presenter = presenter
        return view
    }
}
