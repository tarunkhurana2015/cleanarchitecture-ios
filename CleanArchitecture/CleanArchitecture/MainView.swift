//
//  MainView.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 5/9/24.
//

import SwiftUI
import Search
import Home
import Profile
import Video
import ComposableArchitecture

struct MainView: View {
    var body: some View {
        TabView {
            HomeView(
                store: Store(initialState: HomeViewReducer.State()) {
                    HomeViewReducer()
                }
            )
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            NavigationStack {
                SearchView(
                    store: Store(initialState: SearchViewReducer.State()) {
                        SearchViewReducer()
                    }
                )
            }
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
            
            
            VideoView(
                store: Store(initialState: VideoViewReducer.State()) {
                    VideoViewReducer()
                }
            )
            .tabItem {
                Label("Video", systemImage: "video.circle")
            }
            
            ProfileView(
                store: Store(initialState: ProfileViewReducer.State()) {
                    ProfileViewReducer()
                }
            )
            .tabItem {
                Label("Profile", systemImage: "person.circle")
            }
        }
    }
}

#Preview {
    MainView()
}
