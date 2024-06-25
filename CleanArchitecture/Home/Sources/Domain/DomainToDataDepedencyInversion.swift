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

enum HomeRepositoryKey: DependencyKey {
    static var liveValue: any HomeRepositoryProtocol = HomeRepository()
    static var testValue: any HomeRepositoryProtocol = MockHomeRepository()
    static var previewValue: any HomeRepositoryProtocol = PreviewHomeRepository()
}

extension DependencyValues {
    public var repositoryHome: HomeRepositoryProtocol {
        get { self[HomeRepositoryKey.self] }
        set { self[HomeRepositoryKey.self] = newValue }
    }
}
