//
//  SecurityInteractor.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 24.05.2022.
//

import Foundation

protocol SecurityInteractorInput: AnyObject {
    
}

protocol SecurityInteractorOutput: AnyObject {
    
}

class SecurityInteractor {
    
    weak var output: SecurityInteractorOutput!
}

//MARK: - SecurityInteractorInput
extension SecurityInteractor: SecurityInteractorInput {
    
}





