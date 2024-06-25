//
//  File.swift
//  
//
//  Created by Tarun Khurana on 4/28/24.
//

import Foundation
import Dependencies
import ComposableArchitecture

public enum LoginState {
    case signIn
    case signedIn(_ userId: String, username: String)
    case error(message: String)
}

@Reducer
public struct SignInViewReducer {
    
    @Dependency(\.userSignInUseCase) var userSignInUseCase
    @Dependency(\.userSignUpUseCase) var userSignUpUseCase
    @Dependency(\.authTokenUseCase) var authTokenUseCase
    
    public init() {
        
    }
    
    @ObservableState
    public struct State: Equatable {
        public static func == (lhs: SignInViewReducer.State, rhs: SignInViewReducer.State) -> Bool {
            return true
        }
        
        
        var loginState: LoginState = .signIn
        var loading = false
        
        public init() {
            
        }
    }
    
    public enum Action {
        case signInButtonTapped(_ email: String, password: String)
        
        case userSignInSuccess(entity: UserEntity)
        case userSignInError(error: Error)
    }
    
    /*
     And finally, to finish conforming to Reducer, you must implement a body property with a Reduce reducer that evolves the state from its current value to the next value given a user action, and returns any effects that the feature wants to execute in the outside world. This almost always begins by switching on the incoming action to determine what logic you need to perform, and the state is provided as inout so you can perform mutations on it directly.
     */
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .signInButtonTapped(email, password: password):
                state.loading = true
                return .run { send in
                    do {
                            let entity = try await userSignInUseCase.execute(email, password: password)
                            await send(.userSignInSuccess(entity: entity))
                       } catch {
                           await send(.userSignInError(error: error))
                       }
                }
            case let .userSignInSuccess(entity):
                state.loading = false
                state.loginState = .signedIn(entity.userId, username: entity.username)
                return .run { send in
                    _ = await authTokenUseCase.executeSave(entity.token)
                    
                    let value = await authTokenUseCase.executeValidation(entity.token)
                    print("token : \(entity.token) ===== \(value)")
                    
                }
            case let .userSignInError(error):
                state.loading = false
                state.loginState = .error(message: error.localizedDescription)
                return .none
            }
        }
      }
}
