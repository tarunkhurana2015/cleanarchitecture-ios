//
//  
//  HomeDetailView.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 5/9/24.
//
//

import SwiftUI
import ComposableArchitecture

import SwiftUI

struct HomeDetailView: View {
    
    let entity: HomeEntity
    @State private var zoomed = false
    
    var body: some View {
        VStack {
            Image(entity.photoStatic, bundle: .module)
                .resizable()
                .aspectRatio(contentMode: zoomed ? .fill  : .fit)
                .onTapGesture {
                    withAnimation {
                        zoomed.toggle()
                    }
                }
            AsyncImage(url: URL(string: entity.photoDynamic)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: zoomed ? .fill  : .fit)
                    .onTapGesture {
                        withAnimation {
                            zoomed.toggle()
                        }
                    }
            } placeholder: {
                ProgressView()
            }

            
            Text(entity.name)
                .font(.title)
            Text("\(entity.miles.formatted()) miles")
            Spacer()
        }.navigationTitle(entity.name)
    }
}

#Preview {
    NavigationStack {
        HomeDetailView(entity: HomeEntity(name: "Salmoberry Trail", photoStatic: "sal", photoDynamic: "https://source.unsplash.com/random/1080x500", miles: 6))
    }
}

