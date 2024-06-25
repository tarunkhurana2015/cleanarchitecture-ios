//
//  
//  HomeUsecase.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 5/9/24.
//
//

import Foundation
import Dependencies

protocol HomeUseCase {
    func execute() async throws -> [HomeEntity]
}

public struct HomeUseCaseImpl: HomeUseCase {
    
    // MARK: Depdency Inversion Principle
    /*
     NOTES:
     - high level modules should not depend on the low level modules, but should depdend on the abstraction
     - If a high level module depends on the low level module then the code becomes tightly coupled.
     - Changes in one class should not break another class.

     */
    /// Domain Layer <- Data Repositories Layer
    @Dependency(\.repositoryHome) var repositoryHome
    
    func execute() async throws -> [HomeEntity] {
        do {
            let entities = try await repositoryHome.fetchHome()
            return entities
        } catch {
            throw error
        }
    }
}
