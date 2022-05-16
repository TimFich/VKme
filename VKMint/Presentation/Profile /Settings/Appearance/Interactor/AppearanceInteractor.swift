//
//  AppearanceInteractor.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 15.05.2022.
//

import Foundation

protocol AppearanceInteractorInput: AnyObject {
    
}

protocol AppearanceInteractorOutput: AnyObject {
    
}

class AppearanceInteractor {
    
    weak var output: AppearanceInteractorOutput!
}

//MARK: - AppearanceInteractorInput
extension AppearanceInteractor: AppearanceInteractorInput {
    
}
