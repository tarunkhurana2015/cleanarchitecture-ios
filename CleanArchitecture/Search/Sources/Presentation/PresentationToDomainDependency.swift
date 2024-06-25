//
//  
//  PresentationToDataDependency.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 5/9/24.
//
//

import Foundation
import Dependencies

enum SearchUsecaseCaseKey: DependencyKey {
    static var liveValue: SearchUseCase = SearchUseCaseImpl()
}
extension DependencyValues {
    var useCaseSearch: SearchUseCase {
        get { self[SearchUsecaseCaseKey.self] }
        set { self[SearchUsecaseCaseKey.self] = newValue }
    }
}

enum RecentsSearchUsecaseCaseKey: DependencyKey {
    static var liveValue: RecentSearchUseCase = RecentSearchUseCaseImpl()
}
extension DependencyValues {
    var useCaseRecentSearch: RecentSearchUseCase {
        get { self[RecentsSearchUsecaseCaseKey.self] }
        set { self[RecentsSearchUsecaseCaseKey.self] = newValue }
    }
}

enum PopularmovieUsecaseCaseKey: DependencyKey {
    static var liveValue: PopularMovieUsecase = PopularMovieUsecaseImpl()
}
extension DependencyValues {
    var useCasePopularMovie: PopularMovieUsecase {
        get { self[PopularmovieUsecaseCaseKey.self] }
        set { self[PopularmovieUsecaseCaseKey.self] = newValue }
    }
}
