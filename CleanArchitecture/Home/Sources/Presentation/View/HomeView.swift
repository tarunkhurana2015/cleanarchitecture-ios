//
//  
//  HomeView.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 5/9/24.
//
//

import SwiftUI
import ComposableArchitecture

public struct HomeView: View {
    
    let store: StoreOf<HomeViewReducer>
    public init(store: StoreOf<HomeViewReducer>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            switch store.viewState {
            case .appeared:
                Text("Home Appeared")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
            case .loading:
                Text("Home Loading...")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
            case let .loaded(entities):
                NavigationStack {
                    Group {
                        List(entities) { entity in
                            NavigationLink(value: entity) {
                                HomeCellView(entity: entity, type: HomeType.allCases.randomElement() ?? .statik)
                            }
                        }
                    }.navigationTitle("Hikes")
                        .navigationDestination(for: HomeEntity.self) { entity in
                            HomeDetailView(entity: entity)
                        }
                }
                
            case let .error(error):
                Text("Home Error: \(error)")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
            }
        } .task {            
            store.send(.loadData)
        } .onAppear {
            store.send(.viewAppeared)
        }
        
    }
}

#Preview {
HomeView(
        store: Store(initialState: HomeViewReducer.State()) {
        HomeViewReducer()
        }
    )
}
