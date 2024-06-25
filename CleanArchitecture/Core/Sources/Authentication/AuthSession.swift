//
//  File.swift
//  
//
//  Created by Tarun Khurana on 4/28/24.
//

import Foundation
import Security

public struct AuthSession {
    
    public init() { }
    
    public func updateToken(_ token: String) async -> Bool {
        let data = Data(token.utf8)
        await KeychainHelper.standard.save(data, service: "access-token", account: "app")
        return true
    }
    
    public func getToken() async -> String {
        let data = await KeychainHelper.standard.read(service: "access-token", account: "app")
        guard let data = data else {
            return ""
        }
        let token = String(data: data , encoding: .utf8)
        return token ?? ""
            
    }
}
