//
//  File.swift
//  
//
//  Created by Tarun Khurana on 4/28/24.
//

import Foundation
import Dependencies

protocol SignUpUserUseCase {
    func execute(_ email: String , username: String, password: String) async throws -> UserEntity
}

struct SignUpUserUserCaseImpl: SignUpUserUseCase {
    
    // MARK: Depdency Inversion Principle
    /*
     NOTES:
     - high level modules should not depend on the low level modules, but should depdend on the abstraction
     - If a high level module depends on the low level module then the code becomes tightly coupled.
     - Changes in one class should not break another class.

     */
    /// Domain Layer <- Data Repositories Layer
    @Dependency(\.userRepository) var userRepository
    
    func execute(_ email: String, username: String, password: String) async throws -> UserEntity {
        
        do {
            let userEntity = try await userRepository.signUp(username, email: email, password: password)
            return userEntity
        } catch {
            throw error
        }
    }
}
