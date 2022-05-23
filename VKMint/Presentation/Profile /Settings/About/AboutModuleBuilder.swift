//
//  AboutModuleBuilder.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 15.05.2022.
//

import Foundation
import UIKit

class AboutModuleBuilder {
    
    func build() -> UIViewController {
        let interactor = AboutInteractor()
        let view = AboutViewController()
        let presenter = AboutPresenter(interactor: interactor, view: view)
        interactor.output = presenter
        view.presenter = presenter
        
        return view
    }
}
