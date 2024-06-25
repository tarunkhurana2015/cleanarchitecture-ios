//
//  
//  DomainToDataDepedencyInversion.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 5/9/24.
//
//

import Foundation
import Dependencies

enum MovieRepositoryKey: DependencyKey {
    static var liveValue: any MovieRepositoryProtocol & SearchRepositoryProtocol = MovieRepository()
    static var testValue: any MovieRepositoryProtocol & SearchRepositoryProtocol = MockMovieRepository()
    static var previewValue: any MovieRepositoryProtocol & SearchRepositoryProtocol = PreviewMovieRepository()
}

extension DependencyValues {
    public var repositoryMovie: MovieRepositoryProtocol & SearchRepositoryProtocol {
        get { self[MovieRepositoryKey.self] }
        set { self[MovieRepositoryKey.self] = newValue }
    }
}
