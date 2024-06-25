//
//  
//  SearchDetailView.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 5/9/24.
//
//

import SwiftUI
import ComposableArchitecture

public struct MovieCellView: View {
    
    let entity: MovieEntity
    public init(entity: MovieEntity) {
        self.entity = entity
    }
    
    public var body: some View {
        VStack {
            HStack {
                AsyncImage(url: entity.posterUrl) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                        .frame(width: 75, alignment: .topLeading)
                } placeholder: {
                    Image(systemName: "video.square")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 75, alignment: .topLeading)
                }.padding(5.0)

                VStack(alignment: .leading, spacing: 10.0) {
                    Text(entity.title)
                        .font(.title2)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .frame(alignment: .topLeading)
                    Text("\(entity.rating.formatted())")
                        .font(.callout)
                   
                    Text(entity.overview)
                        .lineLimit(3)
                        .font(.caption)
                }
            }
        }
    }
}

#Preview {
    MovieCellView(entity: MovieEntity(id: 1, title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic, 84 years later. A young Rose boards the ship with her mother and fiancé. Meanwhile, Jack Dawson and Fabrizio De Rossi win third-class tickets aboard the ship. Rose tells the whole story from Titanic's departure through to its death—on its first and last voyage—on April 15, 1912.", posterPath: "/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", rating: 6.2))
}
