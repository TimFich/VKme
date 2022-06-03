//
//  LongPollManager.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 08.05.2022.
//

import Foundation
import SwiftyVK

class LongPollManager {
    
    //MARK: - Properties
    static let shared = LongPollManager()
    private var onReceiveEvent: [Int: [(Data) -> Void]] = [:]
    
    public func start() {
        VK.sessions.default.longPoll.start(version: .third, onReceiveEvents: { events in
            for event in events {
                switch event {
                case .forcedStop, .historyMayBeLost:
                    return
                case .type1(let data):
                    self.processEvent(number: 1, data: data)
                    return
                case .type2(let data):
                    self.processEvent(number: 2, data: data)
                    return
                case .type3(let data):
                    self.processEvent(number: 3, data: data)
                    return
                case .type4(let data):
                    self.processEvent(number: 4, data: data)
                    return
                case .type5(let data):
                    self.processEvent(number: 5, data: data)
                    return
                case .type6(let data):
                    self.processEvent(number: 6, data: data)
                    return
                case .type7(let data):
                    self.processEvent(number: 7, data: data)
                    return
                case .type8(let data):
                    self.processEvent(number: 8, data: data)
                    return
                case .type9(let data):
                    self.processEvent(number: 9, data: data)
                    return
                case .type10(let data):
                    self.processEvent(number: 10, data: data)
                    return
                case .type11(let data):
                    self.processEvent(number: 11, data: data)
                    return
                case .type12(let data):
                    self.processEvent(number: 12, data: data)
                    return
                case .type13(let data):
                    self.processEvent(number: 13, data: data)
                    return
                case .type14(let data):
                    self.processEvent(number: 14, data: data)
                    return
                case .type51(let data):
                    self.processEvent(number: 51, data: data)
                    return
                case .type52(let data):
                    self.processEvent(number: 52, data: data)
                    return
                case .type61(let data):
                    self.processEvent(number: 61, data: data)
                    return
                case .type62(let data):
                    self.processEvent(number: 62, data: data)
                    return
                case .type70(let data):
                    self.processEvent(number: 70, data: data)
                    return
                case .type80(let data):
                    self.processEvent(number: 80, data: data)
                    return
                case .type114(let data):
                    self.processEvent(number: 114, data: data)
                    return
                }
            }
        })
    }
    
    public func addOnReceiveCompletion(eventNumber: Int, completion: @escaping (Data) -> Void) {
        var completions = onReceiveEvent[eventNumber]
        guard completions != nil else {
            completions = []
            completions?.append(completion)
            onReceiveEvent[eventNumber] = completions
            return
        }
        completions?.append(completion)
        onReceiveEvent[eventNumber] = completions
    }
    
    private init() {}
    
    private func processEvent(number: Int, data: Data) {
        let completions = onReceiveEvent[number] ?? []
        for completion in completions {
            completion(data)
        }
    }
}
