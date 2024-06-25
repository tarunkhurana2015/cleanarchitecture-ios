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
public struct SearchResultsViewReducer {
    
    @Dependency(\.useCaseSearch) var useCaseSearch
    @Dependency(\.useCaseRecentSearch) var useCaseRecentSearch
    
    public init() {
    }
    
    @ObservableState
    public struct State {
        
        public enum ViewState {
            case appeared
            case loading
            case loaded(entities: [MovieEntity])
            case error(error: Error)
        }
        var viewState: ViewState = .appeared        
    }
    
    public enum Action {
        case viewAppeared
        case loadData(searchTerm: String)
        case loadedData(entities: [MovieEntity])
        case errorInLoadingData(error: Error)
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            
            switch action {
            case .viewAppeared:
                state.viewState = .appeared
                return .none
            case let .loadData(searchTerm):
                state.viewState = .loading
                return .run { send in
                    do {
                        async let _ = try useCaseRecentSearch.execute(for: searchTerm)
                        let entities = try await useCaseSearch.execute(for: searchTerm)
                        await send(.loadedData(entities: entities))
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
            }
        }
    }
    
}
