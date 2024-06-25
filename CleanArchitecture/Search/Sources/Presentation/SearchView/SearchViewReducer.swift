//
//  
//  SearchViewReducer.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 5/9/24.
//
//

import Foundation
import ComposableArchitecture
import Dependencies

@Reducer
public struct SearchViewReducer {
            
    public init() {}
    
    @ObservableState
    public struct State {
        
        public enum SearchState {
            case searchLandingView
            case searchRecentsView
            case searchResultsView(searchTerm: String)
        }
        
        public enum ViewState {
            case appeared
            case loading
            case loaded
            case error(error: Error)
        }
        
        var viewState: ViewState = .appeared
        var searchState: SearchState = .searchLandingView
        var searchTerm: String = ""
        
        public init() {}
    }
    
    public enum Action {
        case viewAppeared
        case loadData
        case loadedData
        case errorInLoadingData(error: Error)
        case search(searchTerm: String)
        case searchFocused
        case searchCleared
        case searchCancelled
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            
            switch action {                
            case .viewAppeared:
                state.viewState = .appeared
                state.searchState = .searchLandingView
                return .none
            case .loadData:
                state.viewState = .loading
                return .run { send in
                    await send(.loadedData)
                }
            case .loadedData:
                state.viewState = .loaded
                return .none
            case let .errorInLoadingData(error):
                state.viewState = .error(error: error)
                return .none
            case let .search( searchTerm):
                state.searchState = .searchResultsView(searchTerm: searchTerm)
                state.searchTerm = searchTerm
                print("new search state: \(state.searchState)")
                return .none
            case .searchFocused:
                state.searchState = .searchRecentsView
                return .none
            case .searchCleared:
                state.searchState = .searchRecentsView
                return .none
            case .searchCancelled:
                state.searchState = .searchLandingView
                return .none
            }
        }
        
    }
}


