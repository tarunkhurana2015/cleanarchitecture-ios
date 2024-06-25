//
//  
//  PreviewVideoEntityRepository.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 6/11/24.
//
//

import Foundation

public struct PreviewVideoRepository: VideoRepositoryProtocol {
    // Implement the Preview fetch
    public func fetchVideos() async throws -> [VideoEntity] {
        throw VideoError.notImplementatedError
    }
}
