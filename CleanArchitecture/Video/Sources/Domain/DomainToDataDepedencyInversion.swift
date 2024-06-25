//
//  
//  DomainToDataDepedencyInversion.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 6/11/24.
//
//

import Foundation
import Dependencies

enum VideoRepositoryKey: DependencyKey {
    static var liveValue: any VideoRepositoryProtocol = VideoRepository()
    static var testValue: any VideoRepositoryProtocol = MockVideoRepository()
    static var previewValue: any VideoRepositoryProtocol = PreviewVideoRepository()
}

extension DependencyValues {
    public var repositoryVideo: VideoRepositoryProtocol {
        get { self[VideoRepositoryKey.self] }
        set { self[VideoRepositoryKey.self] = newValue }
    }
}
