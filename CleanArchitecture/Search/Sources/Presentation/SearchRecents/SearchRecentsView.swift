//
//  SwiftUIView.swift
//  
//
//  Created by Tarun Khurana on 5/13/24.
//

import SwiftUI
import ComposableArchitecture

struct SearchRecentsView: View {
    
    let store: StoreOf<SearchRecentsViewReducer>
    @Binding var selectedText: String
    
    var body: some View {
        VStack{
            switch store.viewState {
            case .loading, .appeared:
                Text("Loading...")
            case let .loaded(entities):
                List {
                    ForEach(entities, id: \.value) { entity in
                        Text(entity.value)
                            .onTapGesture {
                                selectedText = entity.value
                            }
                    }
                    if entities.count > 0 {
                        Button {
                            store.send(.cleanRecents)
                        } label: {
                            Text("Clear All ")
                                .foregroundColor(.red)
                        }
                    } else {
                        Text("No Recent Searches")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }

            case let .error(error):
                Text("\(error.localizedDescription)")
            }
        } .onAppear {
            store.send(.viewAppeared)
            
        }
    }
}

#Preview {
    SearchRecentsView(store: Store(initialState: SearchRecentsViewReducer.State()) {
        SearchRecentsViewReducer()
    }, selectedText: .constant("Titanic"))
}
