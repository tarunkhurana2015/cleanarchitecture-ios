//
//  
//  SearchRepository.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 5/9/24.
//
//

import Foundation
import Dependencies
import CoreData
import Storage

public actor MovieRepository: MovieRepositoryProtocol {
    
    @Dependency(\.networkSession) var networkSession
    @Dependency(\.coreDataStack) var coreDataStack
    
    public func searchMovies(with term: String) async throws -> [MovieEntity] {
                
        do {
            guard let request = await MovieRequestFactory().makeMoviesRequest(term) else {
                throw MovieError.requestNotFormed
            }
            let data = try await networkSession.request(request)
            let decoder = JSONDecoder()
            return try decoder.decode(MoviesResult.self, from: data).results
        } catch {
            throw MovieError.noDataFound
        }
    }
    
    public func popularMovies(_ page: String) async throws -> [MovieEntity] {
        do {
            guard let request = await MovieRequestFactory().makePopularMoviesRequest(page) else {
                throw MovieError.requestNotFormed
            }
            let data = try await networkSession.request(request)
            let decoder = JSONDecoder()
            return try decoder.decode(MoviesResult.self, from: data).results
        } catch {
            throw MovieError.noDataFound
        }
    }
}

extension MovieRepository: SearchRepositoryProtocol {
    
    public func getRecentsSearches() async throws -> [RecentEntity] {
                
        let request: NSFetchRequest<Recent> = Recent.fetchRequest()
        let sort = NSSortDescriptor(key: "time", ascending: false)
        request.fetchLimit = 5
        request.sortDescriptors = [sort]
        do {
            guard let mainContext = coreDataStack?.mainContext else {
                return []
            }
            let recents = try mainContext.fetch(request)
            return recents.map { RecentEntity(value: $0.value ?? "") }
           
        } catch {
            throw error
        }
    }
    
    public func setRecentsSearch(value: String) async throws {
        
        guard let mainContext = coreDataStack?.mainContext else {
            return
        }
        let recent = Recent(context: mainContext)
        recent.value = value
        recent.time = Date.now
        
        Task {
            do {
                try await coreDataStack?.save()
            } catch {
                
            }
        }
    }
    
    public func cleanRecentSearch() async throws {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Recent")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        guard let mainContext = coreDataStack?.mainContext else {
            return
        }
        
        do {
            try mainContext.execute(batchDeleteRequest)
        } catch {
            throw error
        }
    }
}

//
//func getRecentsSearches() async throws -> [Recent] {
//            
//    Future<[Recent], Error> { promise in
//        let request: NSFetchRequest<Recent> = Recent.fetchRequest()
//        do {
//            let recents = try coreDataStack.mainContext.fetch(request)
//            promise(.success(recents))
//        } catch {
//            promise(.failure(error))
//        }
//    }
//    .eraseToAnyPublisher()
//}
