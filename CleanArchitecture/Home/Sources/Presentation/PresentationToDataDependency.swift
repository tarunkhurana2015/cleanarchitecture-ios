//
//  
//  PresentationToDataDependency.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 5/9/24.
//
//

import Foundation
import Dependencies

enum HomeUsecaseCaseKey: DependencyKey {
    static var liveValue: HomeUseCase = HomeUseCaseImpl()
}
extension DependencyValues {
    var useCaseHome: HomeUseCase {
        get { self[HomeUsecaseCaseKey.self] }
        set { self[HomeUsecaseCaseKey.self] = newValue }
    }
}
