//
//  AppearanceModuleBuilder.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 15.05.2022.
//

import Foundation
import UIKit

class AppearanceModuleBuilder {
    
    func build() -> UIViewController {
        let interactor = AppearanceInteractor()
        let view = AppearanceViewController()
        let presenter = AppearancePresenter(interactor: interactor, view: view)
        interactor.output = presenter
        view.presenter = presenter
        return view
    }
}
