//
//  
//  SearchRepositortyProtocol.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 5/9/24.
//
//

import Foundation

public protocol MovieRepositoryProtocol {
    func searchMovies(with term: String) async throws -> [MovieEntity]
    func popularMovies(_ page: String) async throws -> [MovieEntity]
}
