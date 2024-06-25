//
//  SwiftUIView.swift
//
//
//  Created by Tarun Khurana on 4/28/24.
//

import SwiftUI
import ComposableArchitecture

public struct RootView: View {
    
    let store: StoreOf<RootViewReducer>
    
    public init(store: StoreOf<RootViewReducer>) {
        self.store = store
    }
    
    public var body: some View {

        VStack {
            if store.viewState == .root {
                Text("Root View")
            } else if store.viewState == .signIn {
                SignInView(store: Store(initialState: SignInViewReducer.State()) {
                    SignInViewReducer()
                })
            } else {
                Text("Home View")
            }
        }.onAppear() {
            store.send(.viewAppeared)
        } 
    }
}

#Preview {
    RootView(
        store: Store(initialState: RootViewReducer.State()) {
            RootViewReducer()
        }
    )        .environment(\.locale, .init(identifier: "en-US"))
}
