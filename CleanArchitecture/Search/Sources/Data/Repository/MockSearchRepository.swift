//
//  
//  MockSearchRepository.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 5/9/24.
//
//

import Foundation
import Storage
import Dependencies
import CoreData

public struct MockMovieRepository: MovieRepositoryProtocol {
        
    @Dependency(\.coreDataStack) var coreDataStack
    
    public func searchMovies(with term: String) async throws -> [MovieEntity] {
        throw MovieError.noDataFound
    }
    
    public func popularMovies(_ page: String) async throws -> [MovieEntity] {
        throw MovieError.noDataFound
    }
}


extension MockMovieRepository: SearchRepositoryProtocol {
    public func cleanRecentSearch() async throws {
        
    }
    
    
    public func getRecentsSearches() async throws -> [RecentEntity] {
                
       return []
    }
    
    public func setRecentsSearch(value: String) async throws {
        
    }
}
