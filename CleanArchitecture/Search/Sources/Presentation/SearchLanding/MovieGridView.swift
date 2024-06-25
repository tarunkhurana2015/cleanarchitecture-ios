//
//  SwiftUIView.swift
//  
//
//  Created by Tarun Khurana on 5/19/24.
//

import SwiftUI

struct MovieGridView: View {
    
    let movieEntity: MovieEntity
    init(movieEntity: MovieEntity) {
        self.movieEntity = movieEntity
    }
    
    @ViewBuilder
    var body: some View {
        VStack {
            AsyncImage(url: movieEntity.posterUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .transition(.opacity.animation(.easeIn))                
                
            } placeholder: {
                Image("Placeholder", bundle: .module)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 500)
            }
            VStack(alignment: .leading) {
                Text(movieEntity.title)
                    .font(.title3)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                Text(movieEntity.overview)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
            }
            .frame(height: 80,alignment: .top)
        }
        .background(.white, in: RoundedRectangle(cornerRadius: 10.0))
        .shadow(color: .white, radius: 5)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
    }
}

#Preview {    
    MovieGridView(movieEntity: MovieEntity(id: 1, title: "Godzilla Minus One", overview: "Postwar Japan is at its lowest point when a new crisis emerges in the form of a giant monster, baptized in the horrific power of the atomic bomb.", posterPath: "/hkxxMIGaiCTmrEArK7J56JTKUlB.jpg", rating: 7.7))
}
