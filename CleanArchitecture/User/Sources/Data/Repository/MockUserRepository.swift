//
//  File.swift
//  
//
//  Created by Tarun Khurana on 4/28/24.
//

import Foundation

public struct MockUserRepository: UserRepositoryProtocol {
    public func signUp(_ username: String, email: String, password: String) async throws -> UserEntity {
        let userEntity = UserEntity(userId: "123456", username: username, token: "abcdef")
        if username.isEmpty {
            throw UserError.unauthorized
        }
        return userEntity
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
