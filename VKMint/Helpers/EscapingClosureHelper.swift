//
//  EscapingClosureHelper.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 10.05.2022.
//

import Foundation

final class EscapingClosureHelper<T> {

    var downloadedPhotos: Int = 0
    var photosCount: Int = 0
    var result: [T] = []

    init(count: Int) {
        self.photosCount = count
    }

    func increase() {
        downloadedPhotos += 1
    }

    func isEnough() -> Bool {
        return downloadedPhotos == photosCount
    }
}
