//
//  CustomButtonForPin.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 26.05.2022.
//

import Foundation
import UIKit

class CustomButtonForPin: UIButton {

    init(title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
