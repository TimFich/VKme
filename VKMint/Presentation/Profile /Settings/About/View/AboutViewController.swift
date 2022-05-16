//
//  AboutViewController.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 16.05.2022.
//

import UIKit

protocol AboutViewInput: AnyObject {
    
}

protocol AboutViewOutput: AnyObject {
    
}

class AboutViewController: UIViewController {
    
    var presenter: AboutPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AboutViewController: AboutViewInput {
    
}
