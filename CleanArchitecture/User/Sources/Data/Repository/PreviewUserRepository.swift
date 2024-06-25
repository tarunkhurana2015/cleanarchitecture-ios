//
//  File.swift
//  
//
//  Created by Tarun Khurana on 4/28/24.
//

import Foundation

public struct PreviewUserRepository: UserRepositoryProtocol {
    
    public func signUp(_ username: String, email: String, password: String) async throws -> UserEntity {
        throw UserError.unauthorized
    }
    
    public func signIn(_ email: String, password: String) async throws -> UserEntity {
        throw UserError.unauthorized
    }
    
    public func saveToken(_ token: String) async -> Bool {
        return false
    }
    
    public func validateToken(_ token: String) async -> Bool {
        return false
    }
    public func fetchToken() async -> String {
        return ""
    }
}
