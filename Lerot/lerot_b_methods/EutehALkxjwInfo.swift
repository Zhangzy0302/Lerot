//
//  vaiETdgba_b_info.swift
//  Faio
//
//  Created by yangyang on 2026/2/25.
//

import Foundation
import Security

// MARK: - Key 定义
enum SecureKey {
    case ruwhxnAKjldkDevid, password

    var key: String {
        switch self {
        case .ruwhxnAKjldkDevid: return "ruwhxnAKjldkDevid"
        case .password: return "password"
        }
    }
}

// MARK: - Keychain 封装
final class RuwhxnAKjldkBInfoPer {

    static let shared = RuwhxnAKjldkBInfoPer()
    private init() {}

    // MARK: - 通用读写
    private func save(_ value: String, for key: SecureKey) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }
        delete(key) // 先删除旧值

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.key,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
        ]

        return SecItemAdd(query as CFDictionary, nil) == errSecSuccess
    }

    private func read(_ key: SecureKey) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var data: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &data)
        guard
            status == errSecSuccess,
            let resultData = data as? Data,
            let value = String(data: resultData, encoding: .utf8)
        else { return nil }
        return value
    }

    private func delete(_ key: SecureKey) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.key
        ]
        SecItemDelete(query as CFDictionary)
    }

    // MARK: - 直接属性访问
    var ruwhxnAKjldkDevid: String {
        get { read(.ruwhxnAKjldkDevid) ?? "" }
        set { save(newValue, for: .ruwhxnAKjldkDevid) }
    }

    var password: String {
        get { read(.password) ?? "" }
        set { save(newValue, for: .password) }
    }
}

// 卸载后不持久
enum VaiETdgbaAppStorageKey {
  static let vaiETdgbaIsB = "vaiETdgbaIsB"
  static let vaiETdgbaPushToken = "vaiETdgbaPushToken"
  static let vaiETdgbaH5Url = "vaiETdgbaH5Url"
    static let vaiETdgbaUserToken = "vaiETdgbaUserToken"
}

final class VaiETdgbaAppStorage {

  private static let ud = UserDefaults.standard

  // MARK: - isAorB
  static var vaiETdgbaIsB: Bool {
    get { ud.bool(forKey: VaiETdgbaAppStorageKey.vaiETdgbaIsB) }
    set { ud.set(newValue, forKey: VaiETdgbaAppStorageKey.vaiETdgbaIsB) }
  }
    
    // MARK: - usertoken
    static var vaiETdgbaUserToken: String {
      get { ud.string(forKey: VaiETdgbaAppStorageKey.vaiETdgbaUserToken) ?? ""}
      set { ud.set(newValue, forKey: VaiETdgbaAppStorageKey.vaiETdgbaUserToken) }
    }

  // MARK: - pushToken
  static var vaiETdgbaPushToken: String {
    get { ud.string(forKey: VaiETdgbaAppStorageKey.vaiETdgbaPushToken) ?? "" }
    set { ud.set(newValue, forKey: VaiETdgbaAppStorageKey.vaiETdgbaPushToken) }
  }

  // MARK: - h5Url
  static var vaiETdgbaH5Url: String {
    get { ud.string(forKey: VaiETdgbaAppStorageKey.vaiETdgbaH5Url) ?? "" }
    set { ud.set(newValue, forKey: VaiETdgbaAppStorageKey.vaiETdgbaH5Url) }
  }
}

var yuryxnAhwifkUsersOrdercode: String = ""
