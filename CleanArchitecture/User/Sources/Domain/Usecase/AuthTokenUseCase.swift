//
//  File.swift
//
//
//  Created by Tarun Khurana on 4/27/24.
//

import Foundation
import Dependencies

protocol SaveAuthTokenUserUseCase {
    func executeSave(_ token: String) async -> Bool
}
protocol FetchAuthTokenUserUseCase {
    func executeFetch() async -> String
}
protocol ValidateAuthTokenUserUseCase {
    func executeValidation(_ token: String) async -> Bool
}

struct AuthTokenUseCase: SaveAuthTokenUserUseCase, ValidateAuthTokenUserUseCase, FetchAuthTokenUserUseCase {
    
    // MARK: Depdency Inversion Principle
    /*
     NOTES:
     - high level modules should not depend on the low level modules, but should depdend on the abstraction
     - If a high level module depends on the low level module then the code becomes tightly coupled.
     - Changes in one class should not break another class.

     */
    /// Domain Layer <- Data Repositories Layer
    @Dependency(\.userRepository) var userRepository
    
    func executeSave(_ token: String) async -> Bool {
        
        return await userRepository.saveToken(token)
    }
    
    func executeValidation(_ token: String) async -> Bool {
        
        return await userRepository.validateToken(token)
    }
    
    func executeFetch() async -> String {
        return await userRepository.fetchToken()
    }
}
