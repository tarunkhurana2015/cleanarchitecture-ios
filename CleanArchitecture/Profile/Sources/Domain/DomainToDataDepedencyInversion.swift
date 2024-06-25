//
//  
//  DomainToDataDepedencyInversion.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 5/10/24.
//
//

import Foundation
import Dependencies

enum ProfileRepositoryKey: DependencyKey {
    static var liveValue: any ProfileRepositoryProtocol = ProfileRepository()
    static var testValue: any ProfileRepositoryProtocol = MockProfileRepository()
    static var previewValue: any ProfileRepositoryProtocol = PreviewProfileRepository()
}

extension DependencyValues {
    public var repositoryProfile: ProfileRepositoryProtocol {
        get { self[ProfileRepositoryKey.self] }
        set { self[ProfileRepositoryKey.self] = newValue }
    }
}
