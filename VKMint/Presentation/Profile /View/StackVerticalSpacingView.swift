//
//  StackVerticalSpacingView.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 14.05.2022.
//

import UIKit

final class StackVerticalSpacingView: UIView {
    private let size: CGFloat
    
    init(size: CGFloat, color: UIColor) {
        self.size = size
        super.init(frame: .zero)
        self.backgroundColor = color
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        makeConstraints()
    }
    
    private func makeConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(size)
        }
    }
}
