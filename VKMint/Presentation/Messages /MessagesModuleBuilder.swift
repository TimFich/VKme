//
//  MessagesModuleBuilder.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 04.04.2022.
//

import Foundation
import UIKit

protocol MessagesModuleOutput: AnyObject {
    func openChat(id: Int, title: String)
}

class MessagesModuleBuilder {
    
    private weak var output: MessagesModuleOutput?
    
    init(output: MessagesModuleOutput) {
        self.output = output
    }
        
    func build() -> UIViewController {
        let interactor = MessagesInteractor()
        let view = MessagesViewController()
        let presenter = MessagesPresenter(interactor: interactor, view: view, output: output!)
        interactor.output = presenter
        view.presenter = presenter
        return view
    }
}


