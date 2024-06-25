//
//  
//  SearchUsecase.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 5/9/24.
//
//

import Foundation
import Dependencies

protocol SearchUseCase {
    func execute(for searchTerm: String) async throws -> [MovieEntity]
}

public struct SearchUseCaseImpl: SearchUseCase {
    
    // MARK: Depdency Inversion Principle
    /*
     NOTES:
     - high level modules should not depend on the low level modules, but should depdend on the abstraction
     - If a high level module depends on the low level module then the code becomes tightly coupled.
     - Changes in one class should not break another class.

     */
    /// Domain Layer <- Data Repositories Layer
    @Dependency(\.repositoryMovie) var repositoryMovie
        
    func execute(for searchTerm: String) async throws -> [MovieEntity] {       
        return try await repositoryMovie.searchMovies(with: searchTerm)
    }
}
