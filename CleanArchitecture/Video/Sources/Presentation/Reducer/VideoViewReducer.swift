//
//  
//  VideoViewReducer.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 6/11/24.
//
//

import Foundation
import ComposableArchitecture
import Dependencies

@Reducer
public struct VideoViewReducer {
        
    @Dependency(\.useCaseVideo) var useCaseVideo
    
    public init() {}
    
    @ObservableState
    public struct State {
        
        public enum ViewState {
            case appeared
            case loading
            case loaded(entity: [VideoEntity])
            case error(error: Error)
        }
        
        var viewState: ViewState = .appeared
        public init() {}
    }
    
    public enum Action {
        case viewAppeared
        case loadData
        case loadedData(entity: [VideoEntity])
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
                        let entity = try await useCaseVideo.execute()
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


