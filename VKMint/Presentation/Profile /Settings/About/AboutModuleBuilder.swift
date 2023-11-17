//
//  AboutModuleBuilder.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 15.05.2022.
//

import Foundation
import UIKit

protocol AboutModuleOutput: AnyObject {
    func aboutWantsToClose()
}

class AboutModuleBuilder {

    // Dependencies
    private weak var output: AboutModuleOutput?

    init(output: AboutModuleOutput) {
        self.output = output
    }

    func build() -> UIViewController {
        let interactor = AboutInteractor()
        let view = AboutViewController()
        let presenter = AboutPresenter(interactor: interactor, view: view, output: output!)
        interactor.output = presenter
        view.presenter = presenter
        return view
    }
}
