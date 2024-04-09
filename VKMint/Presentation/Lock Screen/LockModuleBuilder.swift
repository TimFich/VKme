//
//  LockScreenModuleBuilder.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 25.05.2022.
//

import Foundation
import UIKit

class LockModuleBuilder {

    func build() -> UIViewController {
        let interactor = LockInteractor()
        let view = LockViewController()
        let presenter = LockPresenter(interactor: interactor, view: view)
        interactor.output = presenter
        view.presenter = presenter
        return view
    }
}
