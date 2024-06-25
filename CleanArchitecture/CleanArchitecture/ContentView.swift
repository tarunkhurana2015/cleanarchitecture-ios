//
//  ContentView.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 4/27/24.
//

import SwiftUI
import User
import ComposableArchitecture

struct ContentView: View {
    
    var body: some View {
        RootView(
            store: Store(initialState: RootViewReducer.State()) {
                RootViewReducer()
            }
        )
//        HikeView(
//            store: Store(initialState: HikeViewReducer.State()) {
//                HikeViewReducer()
//            }
//        )
    }
}

#Preview {    
    ContentView()
}
