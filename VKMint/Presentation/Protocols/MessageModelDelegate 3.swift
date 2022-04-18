//
//  MessageModelDelegate.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 02.02.2022.
//

import Foundation

protocol MessageModelDelegate: AnyObject {
    func didLoadConversations()
    func didLoadChats()
}
