//
//  File.swift
//  
//
//  Created by Tarun Khurana on 4/29/24.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct RootViewReducer {
    
    public init() { }
    
    @Dependency(\.authTokenUseCase) var authTokenUseCase
    
    @ObservableState
    public struct State {
        
        public enum ViewState {
            case root
            case signIn
            case home
        }
        
        var viewState: ViewState = .root
        public init() {
            
        }
    }
    
    public enum Action {
        case viewAppeared
        case showSignInView
        case showHomeView
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .viewAppeared:                
                return .run { send in
                    let token = await authTokenUseCase.executeFetch()
                    let isValid = await authTokenUseCase.executeValidation(token)
                    if(!isValid) {
                        await send(.showSignInView)
                    } else {
                        return await send(.showHomeView)
                    }
                }
            case .showSignInView:
                state.viewState = .signIn
                return .none
            case .showHomeView:
                state.viewState = .home
                return .none
            }
        }
    }
}
