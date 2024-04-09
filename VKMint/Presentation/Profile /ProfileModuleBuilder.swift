//
//  ProfileModuleBuilder.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 10.05.2022.
//

import Foundation
import UIKit

protocol ProfileModuleOutput: AnyObject {
    func moduleWantsToOpenAuthScreen()
    func moduleWantsToOpenSetting(flag: Int)
}

class ProfileModuleBuilder {

    private weak var output: ProfileModuleOutput?

    init(output: ProfileModuleOutput) {
        self.output = output
    }

    func build() -> UIViewController {
        let interactor = ProfileInteractor()
        let view = ProfileViewController()
        let presenter = ProfilePresenter(interactor: interactor, view: view, output: output!)
        interactor.output = presenter
        view.presenter = presenter
        return view
    }
}
