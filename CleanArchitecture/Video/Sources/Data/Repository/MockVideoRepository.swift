//
//  
//  MockVideoRepository.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 6/11/24.
//
//

import Foundation

public struct MockVideoRepository: VideoRepositoryProtocol {
    public func fetchVideos() async throws -> [VideoEntity] {
        throw VideoError.notImplementatedError
    }
    
    // Implement the Mock Json fetch
}
