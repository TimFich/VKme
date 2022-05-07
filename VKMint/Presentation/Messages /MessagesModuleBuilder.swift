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
        let interactor = MessagesInteractor()
        let view = MessagesViewController()
        let presenter = MessagesPresenter(interactor: interactor, view: view)
        interactor.output = presenter
        view.presenter = presenter
        return view
    }
}


