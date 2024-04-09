//
//  AudioChatMessage.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 30.05.2022.
//

import Foundation
import MessageKit

struct AudioChatMessage: AudioItem {

    var url: URL

    var duration: Float

    var size: CGSize
}
