//
//  
//  ProfileViewReducer.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 5/10/24.
//
//

import Foundation
import ComposableArchitecture
import Dependencies

@Reducer
public struct ProfileViewReducer {
        
    @Dependency(\.useCaseProfile) var useCaseProfile
    
    public init() {}
    
    @ObservableState
    public struct State {
        
        public enum ViewState {
            case appeared
            case loading
            case loaded(entity: ProfileEntity)
            case error(error: Error)
        }
        
        var viewState: ViewState = .appeared
        public init() {}
    }
    
    public enum Action {
        case viewAppeared
        case loadData
        case loadedData(entity: ProfileEntity)
        case errorInLoadingData(error: Error)
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                state.viewState = .appeared
                return .none
            case .loadData:
                state.viewState = .loading
                return .run { send in
                    do {        
                        try await Task.sleep(nanoseconds: 1_000_000_000)
                        let entity = try await useCaseProfile.execute()
                        await send(.loadedData(entity: entity))
                    } catch {
                        await send(.errorInLoadingData(error: error))
                    }
                }
                
            case let .loadedData(entity):
                state.viewState = .loaded(entity: entity)
                return .none
            case let .errorInLoadingData(error):
                state.viewState = .error(error: error)
                return .none
            }
        }
    }
}


