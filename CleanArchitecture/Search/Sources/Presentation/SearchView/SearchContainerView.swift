//
//  SwiftUIView.swift
//  
//
//  Created by Tarun Khurana on 5/12/24.
//

import SwiftUI
import ComposableArchitecture
import Dependencies
import CoreData
import Storage

struct SearchContainerView: View {
    
    let store: StoreOf<SearchViewReducer>
    
    @Environment(\.isSearching) var isSearching
    
    @State var searchTerm: String = ""
    
    public init(store: StoreOf<SearchViewReducer>) {
        self.store = store        
    }
    
    var body: some View {
        switch store.searchState {
        case .searchLandingView: // initial search state
            SearchLandingView(store: Store(initialState: SearchLandingViewReducer.State()) {
                SearchLandingViewReducer()
            }, moveToTopIndicator: .constant(false)) 
            // change the search state on tapping the searchbox to .searchRecents
            .onChange(of: isSearching, perform: { newValue in
                store.send(.searchFocused)
            })

        case .searchRecentsView:
            SearchRecentsView(store: Store(initialState: SearchRecentsViewReducer.State()) {
                SearchRecentsViewReducer()
            }, selectedText: $searchTerm) // pass the search term as Binding so the Recent search can selected and populated back to this view.
            // If the cancel button was pressed, show .searchLanding
            .onChange(of: isSearching, perform: { newValue in
                if !newValue {
                    store.send(.searchCancelled)
                }
            }) 
            // if the search term was changed , show the .searchresults
            .onChange(of: searchTerm, perform: { newValue in
                store.send(.search(searchTerm: newValue))
            })
        case let .searchResultsView(searchTerm):
            SearchResultsView(store: Store(initialState: SearchResultsViewReducer.State()) {
                SearchResultsViewReducer()
            }, searchTerm: searchTerm)
            // If the cancel button was pressed, show .searchLanding
            .onChange(of: isSearching, perform: { newValue in
                if !newValue {
                    store.send(.searchCancelled)
                }
            })
            
        }
    }
}

let movies = [
    MovieEntity(id: 1, title: "Godzilla Minus One", overview: "Postwar Japan is at its lowest point when a new crisis emerges in the form of a giant monster, baptized in the horrific power of the atomic bomb.", posterPath: "", rating: 7.7),
    MovieEntity(id: 2, title: "Kingdom of the Planet of the Apes", overview: "Several generations in the future following Caesar's reign, apes are now the dominant species and live harmoniously while humans have been reduced to living in the shadows. As a new tyrannical ape leader builds his empire, one young ape undertakes a harrowing journey that will cause him to question all that he has known about the past and to make choices that will define a future for apes and humans alike.", posterPath: "/gKkl37BQuKTanygYQG1pyYgLVgf.jpg", rating: 7.255),
    MovieEntity(id: 3, title: "Ghostbusters: Frozen Empire", overview: "After the original team developed a top-secret research laboratory to take the shattered ghosts to the next level. But when the discovery of an ancient artifact unleashes an evil force, both new and old must join forces to protect their homeland and save the world from the Second Ice Age... from the very thing that unleashes an unstoppable force from the depths of history. As chaos reigns and pure evil plunges the world into darkness, the Ghostbusters must step forward once again to save humanity from the brink of doom. With two generations of Ghostbusters fighting side by side, the stakes have never been higher. Will they be able to avert the inevitable before everything freezes?", posterPath: "/e1J2oNzSBdou01sUvriVuoYp0pJ.jpg", rating: 6.7),
    MovieEntity(id: 4, title: "Godzilla x Kong: The New Empire", overview: "", posterPath: "/nBVYp2xxx2R02n21EGlDky8CgWR.jpg", rating: 7.0),
    MovieEntity(id: 5, title: "Abigail", overview: "Titatic is a Punjabi feature film. It is family movie. Titanic is based on a young boy's life whose dreams are so high. He wants to join Indian Navy. Unfortunately his life completely changed due to week financial conditions at home. He starts his work at low level driving of Autoriksha. He works so hard and he faces many obstacles in this work. At the end he accepted that his vehicle is submarine for him.", posterPath: "/7qxG0zyt29BI0IzFDfsps62kbQi.jpg", rating: 8.1),
    MovieEntity(id: 6, title: "Un père idéal", overview: "", posterPath: "/4xJd3uwtL1vCuZgEfEc8JXI9Uyx.jpg", rating: 7.18)
]
#Preview {
    
    SearchContainerView(store: Store(initialState: SearchViewReducer.State(), reducer: {
        SearchViewReducer()
    }))
    
}
