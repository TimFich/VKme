//
//  LockPresenter.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 26.05.2022.
//

import Foundation
import UIKit

class LockPresenter {

    // MARK: - Properties
    private var interactor: LockInteractor
    weak var view: LockViewController?

    init(interactor: LockInteractor, view: LockViewController) {
        self.interactor = interactor
        self.view = view
    }
}

// MARK: - SecurityInteractorOutput
extension LockPresenter: LockInteractorOutput {
}

// MARK: - LockViewOutput
extension LockPresenter: LockViewOutput {
    func needPassword() -> String {
        interactor.needPassword()
    }
}
