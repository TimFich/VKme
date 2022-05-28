//
//  SecurityPresenter.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 24.05.2022.
//

import Foundation
import UIKit

class SecurityPresenter {
    
    //MARK: - Properties
    private var interactor: SecurityInteractor
    weak var view: SecurityViewController?
    
    init(interactor: SecurityInteractor, view: SecurityViewController) {
        self.interactor = interactor
        self.view = view
    }
}

//MARK: - SecurityInteractorOutput
extension SecurityPresenter: SecurityInteractorOutput {
    
}

extension SecurityPresenter: SecurityViewOutput {
    func addPinCodePressed(parentViewController: UINavigationController, flag: Bool) {
        interactor.performPinCodeScreen(parentViewController: parentViewController, flag: flag)
    }
}
