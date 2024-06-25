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

protocol RecentSearchUseCase {
    
    func execute() async throws -> [RecentEntity]
    func execute(for searchTerm: String) async throws
    func executeClearSearch() async throws
}

public struct RecentSearchUseCaseImpl: RecentSearchUseCase {
    
    // MARK: Depdency Inversion Principle
    /*
     NOTES:
     - high level modules should not depend on the low level modules, but should depdend on the abstraction
     - If a high level module depends on the low level module then the code becomes tightly coupled.
     - Changes in one class should not break another class.

     */
    /// Domain Layer <- Data Repositories Layer
    @Dependency(\.repositoryMovie) var repositoryMovie
        
    func execute() async throws -> [RecentEntity] {

        do {
            return try await repositoryMovie.getRecentsSearches()
        }
        catch {
            throw error
        }

    }
    
    func execute(for searchTerm: String) async throws {

        do {
            return try await repositoryMovie.setRecentsSearch(value: searchTerm)
        }
        catch {
            throw error
        }

    }
    
    func executeClearSearch() async throws {
        do {
            return try await repositoryMovie.cleanRecentSearch()
        }
        catch {
            throw error
        }
    }
}
