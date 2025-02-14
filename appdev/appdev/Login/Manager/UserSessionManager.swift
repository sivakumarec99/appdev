//
//  UserSessionManager.swift
//  appdev
//
//  Created by JIDTP1408 on 14/02/25.
//

import Foundation
import Security

struct UserSessionManager {
    
    static let shared = UserSessionManager()
    private let userDefaults = UserDefaults.standard
    
    private let userIdKey = "userId"
    private let userNameKey = "userName"
    private let userEmailKey = "userEmail"
    private let authTokenKey = "authToken"

    private init() {}
    
    // MARK: - Save User Data
    func saveUserData(userId: String, name: String, email: String, token: String) {
        userDefaults.set(userId, forKey: userIdKey)
        userDefaults.set(name, forKey: userNameKey)
        userDefaults.set(email, forKey: userEmailKey)
        saveAuthToken(token)
    }
    
    // MARK: - Retrieve User Data
    func getUserData() -> (userId: String?, name: String?, email: String?) {
        let userId = userDefaults.string(forKey: userIdKey)
        let name = userDefaults.string(forKey: userNameKey)
        let email = userDefaults.string(forKey: userEmailKey)
        return (userId, name, email)
    }
    
    func getAuthToken() -> String? {
        return retrieveAuthToken()
    }
    
    // MARK: - Remove User Data (Logout)
    func clearUserData() {
        userDefaults.removeObject(forKey: userIdKey)
        userDefaults.removeObject(forKey: userNameKey)
        userDefaults.removeObject(forKey: userEmailKey)
        deleteAuthToken()
    }
    
    // MARK: - Securely Store Auth Token
    private func saveAuthToken(_ token: String) {
        guard let data = token.data(using: .utf8) else { return }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: authTokenKey,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    
    private func retrieveAuthToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: authTokenKey,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess, let retrievedData = dataTypeRef as? Data {
            return String(data: retrievedData, encoding: .utf8)
        }
        return nil
    }
    
    private func deleteAuthToken() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: authTokenKey
        ]
        SecItemDelete(query as CFDictionary)
    }
}
