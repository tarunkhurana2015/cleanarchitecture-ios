//
//  
//  VideoUsecase.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 6/11/24.
//
//

import Foundation
import Dependencies

protocol VideoUseCase {
    func execute() async throws -> [VideoEntity]
}

public struct VideoUseCaseImpl: VideoUseCase {
    
    // MARK: Depdency Inversion Principle
    /*
     NOTES:
     - high level modules should not depend on the low level modules, but should depdend on the abstraction
     - If a high level module depends on the low level module then the code becomes tightly coupled.
     - Changes in one class should not break another class.

     */
    /// Domain Layer <- Data Repositories Layer
    @Dependency(\.repositoryVideo) var repositoryVideo
    
    func execute() async throws -> [VideoEntity] {
        try await repositoryVideo.fetchVideos()
    }
}
