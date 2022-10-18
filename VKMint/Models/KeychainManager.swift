//
//  KeyChainManager.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 26.05.2022.
//

import Foundation
import SwiftyVK

private enum KeychainErorr: Error {
    case duplicateEntry
    case unknown(OSStatus)
}

protocol KeychainManagerInput: AnyObject {
    func saveChain(password: String)
    func getChain() -> String
    func isExist() -> Bool
}

final class KeychainManager {

    private func keychainSave(service: String, account: String, password: Data) throws {

        let quary: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecValueData as String: password as AnyObject
        ]

        let status = SecItemAdd(quary as CFDictionary, nil)

        guard status != errSecDuplicateItem else {
            print("*️⃣Keychain saved error")
            throw KeychainErorr.duplicateEntry
        }

        guard status == errSecSuccess else {
            print("*️⃣Keychain saved error")
            throw KeychainErorr.unknown(status)
        }
        print("*️⃣Keychain saved success")
    }

    private func keychainGet(service: String, account: String) -> Data {

        let quary: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var result: AnyObject?

        _ = SecItemCopyMatching(quary as CFDictionary, &result)

        return result as? Data ?? Data()
    }
}

// MARK: - KeychainManagerInput

extension KeychainManager: KeychainManagerInput {
    func saveChain(password: String) {
        try? keychainSave(service: "VKMint",
                          account: UserDefaults.standard.object(forKey: UserDefaultsKeys.userId.rawValue) as! String,
                          password: password.data(using: .utf8) ?? Data())
    }

    func getChain() -> String {
        let password = self.keychainGet(service: "VKMint",
                                        account: UserDefaults.standard.object(forKey: UserDefaultsKeys.userId.rawValue) as! String)
        return String(decoding: password, as: UTF8.self)
    }

    func isExist() -> Bool {
        let password = getChain()

        if password.isEmpty {
            return false
        } else {
            return true
        }
    }
}
