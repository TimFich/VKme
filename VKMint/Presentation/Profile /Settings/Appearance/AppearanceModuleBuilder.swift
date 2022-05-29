//
//  AppearanceModuleBuilder.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 15.05.2022.
//

import Foundation
import UIKit

protocol AppearanceModuleOutput: AnyObject {
    func appearenceWantsToClose()
}

class AppearanceModuleBuilder {
    
    private weak var output: AppearanceModuleOutput?
    
    init(output: AppearanceModuleOutput) {
        self.output = output
    }
    
    func build() -> UIViewController {
        let interactor = AppearanceInteractor()
        let view = AppearanceViewController()
        let presenter = AppearancePresenter(interactor: interactor, view: view, output: output!)
        interactor.output = presenter
        view.presenter = presenter
        return view
    }
}
