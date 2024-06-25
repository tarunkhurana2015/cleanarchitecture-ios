//
//  
//  SearchView.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 5/9/24.
//
//

import SwiftUI
import ComposableArchitecture

extension MovieEntity: Hashable {
    public static func == (lhs: MovieEntity, rhs: MovieEntity) -> Bool {
        return true
    }
    
    public func hash(into hasher: inout Hasher) {
        
    }
}


public struct SearchView: View {
    
    let store: StoreOf<SearchViewReducer>
    public init(store: StoreOf<SearchViewReducer>) {
        self.store = store
    }
    
    @State private var searchTerm = ""    
    
    public var body: some View {
        VStack {
            switch store.viewState {
            case .appeared:
                Text("Search Appeared")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
            case .loading:
                Text("Search Loading...")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
            case .loaded:
                VStack() {
                    // inject the same store to the child container
                    SearchContainerView(store: store)
                }
                .searchable(text: $searchTerm, prompt: "Search for Movies")
                .onChange(of: searchTerm, perform: { value in
                    if !searchTerm.isEmpty {
                        store.send(.search(searchTerm: searchTerm))
                    } else {
                        store.send(.searchCleared)
                    }
                })
                .onChange(of: store.searchTerm, perform: {  value in
                    // updating the textbox test with the new search text
                    searchTerm = store.searchTerm
                })
                                
            case let .error(error):                
                Text("Search Error: \(error)")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
            }
        }
        .navigationTitle("Search")
        .onFirstAppear {
            Task {
                store.send(.loadData)
            }
        }        
    }
}

#Preview {    
    NavigationStack {
        SearchView(
            store: Store(initialState: SearchViewReducer.State()) {
            SearchViewReducer()
            }
        )
    }
}
