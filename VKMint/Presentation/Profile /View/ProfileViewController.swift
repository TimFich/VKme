//
//  ProfileViewController.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 10.05.2022.
//

import Foundation
import UIKit

protocol ProfileViewOutput {
    func viewDidLoad() 
}

protocol ProfileViewInput {
    func needToUpdateProfile(person: ProfileData)
}

class ProfileViewController: UIViewController {
    
    let label = UILabel()
    
    var presenter: ProfilePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        presenter.viewDidLoad()
        label.text = "text"
        label.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(20)
        }
    }
}

extension ProfileViewController: ProfileViewInput {
    func needToUpdateProfile(person: ProfileData) {
        label.text = person.firstName
        print(person)
    }
}
