//
//  ContactsModuleBuilder.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 09.05.2022.
//

import Foundation
import UIKit

class ContactsModuleBuilder {
        
    func build() -> UIViewController {
        let interactor = СontactsInteractor()
        let view = ContactsViewController()
        let presenter = ContactsPresenter(interactor: interactor, view: view)
        interactor.output = presenter
        view.presenter = presenter
        return view
    }
}
