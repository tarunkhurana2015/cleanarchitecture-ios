//
//  File.swift
//
//
//  Created by Tarun Khurana on 5/13/24.
//

import Foundation
import ComposableArchitecture
import Dependencies

@Reducer
public struct SearchRecentsViewReducer {
    
    @Dependency(\.useCaseRecentSearch) var useCaseRecentSearch
    
    public init() {
    }
    
    @ObservableState
    public struct State {
        
        public enum ViewState {
            case appeared
            case loading
            case loaded(entities: [RecentEntity])
            case error(error: Error)
        }
        var viewState: ViewState = .appeared
    }
    
    public enum Action {
        case viewAppeared
        case loadData
        case loadedData(entities: [RecentEntity])
        case errorInLoadingData(error: Error)
        case cleanRecents
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            
            switch action {
            case .viewAppeared:
                state.viewState = .appeared
                return .send(.loadData)
            case .loadData:
                state.viewState = .loading
                return .run { send in           
                    do {
                        let recents = try await useCaseRecentSearch.execute()
                        await send(.loadedData(entities: recents))                        
                    } catch {
                        await send(.errorInLoadingData(error: error))
                    }
                    
                }
            case let .loadedData(entities):
                state.viewState = .loaded(entities: entities)
                return .none
            case let .errorInLoadingData(error):
                state.viewState = .error(error: error)
                return .none
            case .cleanRecents:
                return .run { send in
                    do {
                        try await useCaseRecentSearch.executeClearSearch()
                        await send(.loadedData(entities: []))
                    } catch {
                        await send(.errorInLoadingData(error: error))
                    }
                }
            }
        }
    }
    
}
