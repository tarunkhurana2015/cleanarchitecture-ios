//
//  
//  ProfileUsecase.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 5/10/24.
//
//

import Foundation
import Dependencies

protocol ProfileUseCase {
    func execute() async throws -> ProfileEntity
}

public struct ProfileUseCaseImpl: ProfileUseCase {
    
    // MARK: Depdency Inversion Principle
    /*
     NOTES:
     - high level modules should not depend on the low level modules, but should depdend on the abstraction
     - If a high level module depends on the low level module then the code becomes tightly coupled.
     - Changes in one class should not break another class.

     */
    /// Domain Layer <- Data Repositories Layer
    @Dependency(\.repositoryProfile) var repositoryProfile
    
    func execute() async throws -> ProfileEntity {
        throw ProfileError.unknown
    }
}
