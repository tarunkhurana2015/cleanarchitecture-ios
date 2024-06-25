//
//  
//  VideoRepositortyProtocol.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 6/11/24.
//
//

import Foundation

public protocol VideoRepositoryProtocol {
    
    func fetchVideos() async throws -> [VideoEntity]
}
