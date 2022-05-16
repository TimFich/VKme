//
//  AppearanceViewController.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 15.05.2022.
//

import UIKit

protocol AppearanceViewInput: AnyObject {
    
}

protocol AppearanceViewOutput: AnyObject {
    
}

class AppearanceViewController: UIViewController {
    
    var presenter: AppearancePresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AppearanceViewController: AppearanceViewInput {
    
}
