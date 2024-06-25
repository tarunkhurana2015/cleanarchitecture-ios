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
public struct SearchLandingViewReducer {
    
    @Dependency(\.useCasePopularMovie) var useCasePopularMovie
    
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
        var page: Int = 1
    }
    
    public enum Action {
        case viewAppeared
        case loadData(oldEntities: [MovieEntity])
        case loadedData(entities: [MovieEntity])
        case loadNextPageData(oldEntities: [MovieEntity])
        case errorInLoadingData(error: Error)
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                state.viewState = .loading
                state.page = 1
                return .send(.loadData(oldEntities: []))            
            case let .loadData(oldEntities):
                let page = state.page
                return .run { send in
                    do {
                        let entities = try await useCasePopularMovie.execute("\(page)")
                        let newEntities = oldEntities + entities // append the new page entities
                        await send(.loadedData(entities: newEntities))
                    } catch {
                        await send(.errorInLoadingData(error: error))
                    }
                }
            case let .loadedData(entities):
                state.viewState = .loaded(entities: entities)
                return .none
            case let .loadNextPageData(oldEntities):
                state.page += 1 // increment the page count
                return .run { send in
                    try await Task.sleep(nanoseconds: 1_000_000_000)
                    await send(.loadData(oldEntities: oldEntities))
                }
            case let .errorInLoadingData(error):
                state.viewState = .error(error: error)
                return .none
            }
        }
    }
    
}
