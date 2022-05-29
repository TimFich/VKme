//
//  ChatModuleBuilder.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 29.05.2022.
//

import Foundation
import UIKit

class ChatModuleBuilder {
    
    private var id: Int
    
    init(id: Int) {
        self.id = id
    }
        
    func build() -> UIViewController {
        let interactor = ChatInteractor(id: id)
        let view = ChatViewController()
        let presenter = ChatPresenter(interactor: interactor, view: view)
        interactor.output = presenter
        view.mainPresenter = presenter
        return view
    }
}
