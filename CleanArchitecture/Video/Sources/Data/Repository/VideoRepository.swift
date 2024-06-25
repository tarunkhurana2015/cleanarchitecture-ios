//
//  
//  VideoRepository.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 6/11/24.
//
//

import Foundation
import Dependencies

public struct VideoRepository: VideoRepositoryProtocol {
    
    @Dependency(\.networkURLSession) var networkURLSession
    
    // Implement the API fetch
    public func fetchVideos() async throws -> [VideoEntity] {
        let url = VideoUrlFactory().makeVideoUrl()
        
        do {
            guard let url = url else {
                throw VideoError.badUrl
            }
            let data = try await networkURLSession.request(URLRequest(url: url))
            guard let entities = try JSONDecoder().decode(VideoResponse.self, from: data).categories.first?.videos else {
                throw VideoError.decodingError
            }
            return entities
            
        } catch {
            throw error
        }
        
    }
}
