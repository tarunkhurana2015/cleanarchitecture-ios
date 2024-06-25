//
//  File.swift
//  
//
//  Created by Tarun Khurana on 4/28/24.
//

import Foundation
import Dependencies

enum SignInUseCaseKey: DependencyKey {
    static var liveValue: SignInUserUseCase = SignInUserUseCaseImpl()
}
extension DependencyValues {
    var userSignInUseCase: SignInUserUseCase {
        get { self[SignInUseCaseKey.self] }
        set { self[SignInUseCaseKey.self] = newValue }
    }
}

enum SignUpUseCaseKey: DependencyKey {
    static var liveValue: SignUpUserUseCase = SignUpUserUserCaseImpl()
}
extension DependencyValues {
    var userSignUpUseCase: SignUpUserUseCase {
        get { self[SignUpUseCaseKey.self] }
        set { self[SignUpUseCaseKey.self] = newValue }
    }
}

enum TokenSaveUseCaseKey: DependencyKey {
    static var liveValue: SaveAuthTokenUserUseCase & ValidateAuthTokenUserUseCase & FetchAuthTokenUserUseCase = AuthTokenUseCase()
}
extension DependencyValues {
    var authTokenUseCase: SaveAuthTokenUserUseCase & ValidateAuthTokenUserUseCase & FetchAuthTokenUserUseCase {
        get { self[TokenSaveUseCaseKey.self] }
        set { self[TokenSaveUseCaseKey.self] = newValue }
    }
}
