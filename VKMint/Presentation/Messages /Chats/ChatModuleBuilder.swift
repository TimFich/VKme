//
//  ChatModuleBuilder.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 29.05.2022.
//

import Foundation
import UIKit

class ChatModuleBuilder {
    
    private let id: Int
    private let title: String
    
    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
        
    func build() -> UIViewController {
        let interactor = ChatInteractor(id: id)
        let view = ChatViewController()
        view.title = title
        let presenter = ChatPresenter(interactor: interactor, view: view)
        interactor.output = presenter
        view.mainPresenter = presenter
        return view
    }
}
