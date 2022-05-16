//
//  AboutInteractor.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 16.05.2022.
//

import Foundation

protocol AboutInteractorInput: AnyObject {
    
}

protocol AboutInteractorOutput: AnyObject {
    
}

class AboutInteractor {
    weak var output: AboutInteractorOutput!
}

extension AboutInteractor: AboutInteractorInput {
    
}
