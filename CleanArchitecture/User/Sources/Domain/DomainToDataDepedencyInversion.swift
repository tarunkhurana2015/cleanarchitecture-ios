//
//  File.swift
//  
//
//  Created by Tarun Khurana on 4/27/24.
//

import Foundation
import Dependencies

enum UserRepositoryKey: DependencyKey {
    static var liveValue: any UserRepositoryProtocol = UserRepository()
    static var testValue: any UserRepositoryProtocol = MockUserRepository()
    static var previewValue: any UserRepositoryProtocol = PreviewUserRepository()
}

extension DependencyValues {
    public var userRepository: UserRepositoryProtocol {
        get { self[UserRepositoryKey.self] }
        set { self[UserRepositoryKey.self] = newValue }
    }
}
