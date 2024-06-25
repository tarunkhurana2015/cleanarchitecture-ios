//
//  
//  PresentationToDataDependency.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 5/10/24.
//
//

import Foundation
import Dependencies

enum ProfileUsecaseCaseKey: DependencyKey {
    static var liveValue: ProfileUseCase = ProfileUseCaseImpl()
}
extension DependencyValues {
    var useCaseProfile: ProfileUseCase {
        get { self[ProfileUsecaseCaseKey.self] }
        set { self[ProfileUsecaseCaseKey.self] = newValue }
    }
}
