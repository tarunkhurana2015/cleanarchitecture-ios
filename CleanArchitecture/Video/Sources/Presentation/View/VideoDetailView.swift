//
//  
//  VideoDetailView.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 6/11/24.
//
//

import SwiftUI
import ComposableArchitecture

public struct VideoDetailView: View {
    
    let entity: VideoEntity
    public init(entity: VideoEntity) {
        self.entity = entity
    }
    
    public var body: some View {
        VStack {
                Text("\(entity)")
        }
    }
}

#Preview {
VideoDetailView(entity: VideoEntity(title: "Elephant Dream", detail: "HBO GO now works with Chromecast -- the easiest way to enjoy online video on your TV. For when you want to settle into your Iron Throne to watch the latest episodes. For $35. Learn how to use Chromecast with HBO GO and more at google.com/chromecast.", subtitle: "By Blender Foundation", thumb: "images/ElephantsDream.jpg", sources: ["http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"]))
}
