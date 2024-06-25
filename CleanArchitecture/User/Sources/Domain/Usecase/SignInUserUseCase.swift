//
//  File.swift
//  
//
//  Created by Tarun Khurana on 4/27/24.
//

import Foundation
import Dependencies

protocol SignInUserUseCase {
    func execute(_ email: String , password: String) async throws -> UserEntity
}

struct SignInUserUseCaseImpl: SignInUserUseCase {
    
    // MARK: Depdency Inversion Principle
    /*
     NOTES:
     - high level modules should not depend on the low level modules, but should depdend on the abstraction
     - If a high level module depends on the low level module then the code becomes tightly coupled.
     - Changes in one class should not break another class.

     */
    /// Domain Layer <- Data Repositories Layer
    @Dependency(\.userRepository) var userRepository
    
    func execute(_ email: String, password: String) async throws -> UserEntity {
        
        do {
            let userEntity = try await userRepository.signIn(email, password: password)
            return userEntity
        } catch {
            throw error
        }
    }
}
