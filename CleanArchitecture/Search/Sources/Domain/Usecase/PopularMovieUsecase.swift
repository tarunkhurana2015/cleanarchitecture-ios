//
//  File.swift
//  
//
//  Created by Tarun Khurana on 5/11/24.
//

import Foundation
import Dependencies

public protocol PopularMovieUsecase {
    func execute(_ page: String) async throws -> [MovieEntity]
}

public struct PopularMovieUsecaseImpl: PopularMovieUsecase {
    
    @Dependency(\.repositoryMovie) var repositoryMovie
    
    public func execute(_ page: String) async throws -> [MovieEntity] {
        return try await repositoryMovie.popularMovies(page)
    }
}
