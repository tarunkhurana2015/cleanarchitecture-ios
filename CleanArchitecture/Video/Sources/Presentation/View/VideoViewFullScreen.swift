//
//  SwiftUIView.swift
//  
//
//  Created by Tarun Khurana on 6/12/24.
//

import SwiftUI
import AVKit

// https://designcode.io/swiftui-handbook-play-video-with-avplayer
struct VideoViewFullScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @State var player = AVPlayer()
    let url: String?
    
    var body: some View {
        ZStack {
            Color.primary.edgesIgnoringSafeArea(.all)
            VideoPlayer(player: player)
            VStack {
                HStack {
                    Spacer()
                    Button("", systemImage: "xmark.circle") {
                        dismiss()
                    }.frame(width: 100, height: 100)
                }
                Spacer()
            }.edgesIgnoringSafeArea(.all)
        }
        .onAppear {
            player = AVPlayer(url: URL(string: url!)!)
            player.play()
        }
    }
}

#Preview {
    VideoViewFullScreen(url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
}
