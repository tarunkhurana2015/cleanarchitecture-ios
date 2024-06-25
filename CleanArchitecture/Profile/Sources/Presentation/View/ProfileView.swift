//
//  
//  ProfileView.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 5/10/24.
//
//

import SwiftUI
import ComposableArchitecture

extension ProfileEntity: Hashable {
    public static func == (lhs: ProfileEntity, rhs: ProfileEntity) -> Bool {
        return true
    }
    
    public func hash(into hasher: inout Hasher) {
        
    }
}


public struct ProfileView: View {
    
    let store: StoreOf<ProfileViewReducer>
    public init(store: StoreOf<ProfileViewReducer>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            switch store.viewState {
            case .appeared:
                Text("Profile Appeared")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
            case .loading:
                Text("Profile Loading...")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
            case let .loaded(entity):
                NavigationStack {
                    VStack {
                        NavigationLink(value: entity) {
                            Text("\(entity)")
                        }
                    }.navigationTitle("Profile")
                        .navigationDestination(for: ProfileEntity.self) { entity in
                        ProfileDetailView(entity: entity)
                        }
                }
                
            case let .error(error):
                Text("Profile Error: \(error)")
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
ProfileView(
        store: Store(initialState: ProfileViewReducer.State()) {
        ProfileViewReducer()
        }
    )
}
