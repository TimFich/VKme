//
//  PlatformImageGenerator.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 10.05.2022.
//

import Foundation
import UIKit

class PlatformImageGenerator {

    func generateImage(platform: Int) -> UIImage? {
        switch platform {
        case 1, 4:
            return UIImage(systemName: "candybarphone")
        case 2:
            return UIImage(systemName: "applelogo")
        case 3:
            return UIImage(systemName: "ipad")
        default:
            return UIImage(systemName: "circle.fill")
        }
    }
}
