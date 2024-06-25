//
//  
//  VideoView.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 6/11/24.
//
//

import SwiftUI
import ComposableArchitecture

extension VideoEntity: Hashable {
    public static func == (lhs: VideoEntity, rhs: VideoEntity) -> Bool {
        return true
    }
    
    public func hash(into hasher: inout Hasher) {
        
    }
}


public struct VideoView: View {
    
    let store: StoreOf<VideoViewReducer>
    public init(store: StoreOf<VideoViewReducer>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            NavigationStack {
                VStack {
                    switch store.viewState {
                    case .appeared:
                        Text("Video Appeared")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                    case .loading:
                        Text("Video Loading...")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                    case let .loaded(entities):
                        List(entities, id: \.id) { entity in
                            VideoItemView(videoEntity: entity)
                        }
                        .listStyle(.plain)
                        
                    case let .error(error):
                        Text("Video Error: \(error)")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                    }
                }.navigationTitle("Videos")
            }
        } .task {
            store.send(.loadData)
        } .onAppear {
            store.send(.viewAppeared)
        }
        
    }
}

#Preview {
VideoView(
        store: Store(initialState: VideoViewReducer.State()) {
            VideoViewReducer()
        }
    )
}
