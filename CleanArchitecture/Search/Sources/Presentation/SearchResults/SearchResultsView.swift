//
//  SwiftUIView.swift
//  
//
//  Created by Tarun Khurana on 5/15/24.
//

import SwiftUI
import ComposableArchitecture

struct SearchResultsView: View {
    
    let store: StoreOf<SearchResultsViewReducer>
    var searchTerm: String
    
    init(store: StoreOf<SearchResultsViewReducer>, searchTerm: String) {
        self.store = store
        self.searchTerm = searchTerm
        store.send(.loadData(searchTerm: searchTerm))
    }
    
    var body: some View {
        VStack {
            switch store.viewState {
            case .loading, .appeared:
                VStack(alignment: .center) {
                    Text("Loading...")
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(maxHeight: .infinity, alignment: .center)
                }
            case let .loaded(entities):
                List(entities, id: \.id) { entity in
                    MovieCellView(entity: entity)
                }
                .listStyle(.plain)
            case let .error(error):
                Text("\(error.localizedDescription)")
            }
        }
        .onAppear(perform: {
            store.send(.viewAppeared)
        })
    }
}

#Preview {
    SearchResultsView(store: Store(initialState: SearchResultsViewReducer.State()){
        
        SearchResultsViewReducer()
    }, searchTerm: "Titanic")
}
