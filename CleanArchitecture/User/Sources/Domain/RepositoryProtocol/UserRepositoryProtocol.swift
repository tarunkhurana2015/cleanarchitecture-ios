//
//  File.swift
//  
//
//  Created by Tarun Khurana on 4/28/24.
//

import Foundation

public protocol UserRepositoryProtocol {
    func signUp(_ username: String, email: String, password: String) async throws -> UserEntity
    func signIn(_ email: String, password: String) async throws -> UserEntity
    
    func saveToken(_ token: String) async -> Bool
    func fetchToken() async -> String
    func validateToken(_ token: String) async -> Bool
}
