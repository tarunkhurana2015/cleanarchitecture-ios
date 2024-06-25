//
//  File.swift
//  
//
//  Created by Tarun Khurana on 4/30/24.
//

import Foundation

struct KeychainHelper {
    static let standard = KeychainHelper()
    private init() {
        
    }
    
    func save(_ data: Data, service: String, account: String) async {
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        
        if status != errSecSuccess {
            
        }
    }
    
    func read(service: String, account: String) async -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return (result as? Data)
    }
}

