//
//  
//  PresentationToDomainDependency.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 6/11/24.
//
//

import Foundation
import Dependencies

enum VideoUsecaseCaseKey: DependencyKey {
    static var liveValue: VideoUseCase = VideoUseCaseImpl()
}
extension DependencyValues {
    var useCaseVideo: VideoUseCase {
        get { self[VideoUsecaseCaseKey.self] }
        set { self[VideoUsecaseCaseKey.self] = newValue }
    }
}
