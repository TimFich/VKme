//
//  MediaChatMessage.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 30.05.2022.
//

import Foundation
import MessageKit

struct MediaChatMessage: MediaItem {
    
    var url: URL?
    
    var image: UIImage?
    
    var placeholderImage: UIImage
    
    var size: CGSize
}
