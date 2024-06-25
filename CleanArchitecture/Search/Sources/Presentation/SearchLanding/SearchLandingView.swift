//
//  SwiftUIView.swift
//  
//
//  Created by Tarun Khurana on 5/13/24.
//

import SwiftUI
import ComposableArchitecture

struct SearchLandingView: View {
    
    let store: StoreOf<SearchLandingViewReducer>
    @Binding var moveToTopIndicator: Bool
    
    private let adaptiveColumn = [
           GridItem(.flexible(),spacing: 15),
           GridItem(.flexible(),spacing: 15)
       ]
    private let singleColumn = [
           GridItem(.flexible()),
       ]
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading) {
                    switch store.viewState {
                    case .loading, .appeared:
                        VStack(alignment: .center) {
                            Text("Loading...")
                                .font(.headline)
                                .fontWeight(.bold)
                                .frame(maxHeight: .infinity, alignment: .center)
                        }
                    case let .loaded(entities):
                        Text("popular movies").id("popolarMovie")
                            .padding(.leading)
                            .font(.title2)
                            .fontWidth(.condensed)
                            .foregroundColor(.secondary)
                            .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        LazyVGrid(columns: adaptiveColumn, spacing: 20) {
                            ForEach(entities, id: \.id) { entity in
                                MovieGridView(movieEntity: entity)
                            }
                        }.padding()
                        LazyVGrid(columns: singleColumn, spacing: 50) {
                            VStack() {
                                HStack{
                                    Spacer()
                                    ProgressView {
                                        Text("Loading...\(store.page)")
                                            .font(.caption)
                                    }
                                    .onAppear { // on display of the progress view, load the next page
                                        store.send(.loadNextPageData(oldEntities: entities))
                                    }
                                    Spacer()
                                }
                            }
                        }.padding()
                        
                    case let .error(error):
                        Text("\(error.localizedDescription)")
                    }
                }
            }
            .onFirstAppear {
                store.send(.viewAppeared)
            }
            .onChange(of: moveToTopIndicator) { _ in
                proxy.scrollTo("popolarMovie")
            }
        }
    }
}

#Preview {
    SearchLandingView(store: Store(initialState: SearchLandingViewReducer.State(), reducer: {
        SearchLandingViewReducer()
    }), moveToTopIndicator: .constant(false))
}
