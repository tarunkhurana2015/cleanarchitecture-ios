//
//  SwiftUIView.swift
//  
//
//  Created by Tarun Khurana on 6/11/24.
//

import SwiftUI

struct VideoItemView: View {
    
    let videoEntity: VideoEntity
    @State private var isPresentedVideoFullScreen = false
    
    var body: some View {
        VStack {
            ZStack {
                AsyncImage(url: URL(string: VideoAPI.imageBaseUrl + "/" + videoEntity.thumb)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
                Button {
                    isPresentedVideoFullScreen.toggle()
                }
                label: {
                Image(systemName: "play.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
                }
                .fullScreenCover(isPresented: $isPresentedVideoFullScreen) { VideoViewFullScreen.init(url: videoEntity.sources.first)
                }
            }
            
            VStack {
                Text(videoEntity.title)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(videoEntity.subtitle)
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(videoEntity.detail)
                    .font(.caption2)
                    .lineLimit(3)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    VideoItemView(videoEntity: VideoEntity(title: "Elephant Dream", detail: "The first Blender Open Movie from 2006", subtitle: "By Blender Foundation", thumb: "images/ForBiggerBlazes.jpg", sources: ["http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"]))
}
