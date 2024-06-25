//
//  SwiftUIView.swift
//  
//
//  Created by Tarun Khurana on 5/9/24.
//

import SwiftUI

enum HomeType: CaseIterable {
    case statik
    case dynamic
}
struct HomeCellView: View {
    
    let entity: HomeEntity
    let type: HomeType
    
    var body: some View {
        HStack(alignment: .top) {
            if (type == .statik ) {
                Image(entity.photoStatic, bundle: .module)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .frame(width: 100)
            } else {
                AsyncImage(url: URL(string: entity.photoDynamic)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .frame(width: 100)
                } placeholder: {
                    ProgressView()
                        .padding(.all)
                }

            }
                
            VStack(alignment:.leading) {
                Text(entity.name)
                    .font(.title2)
                Text("\(entity.miles.formatted()) miles")
                    .font(.title3)
                    .fontWeight(.bold)
            }
        }
    }
}

#Preview {
    HomeCellView(entity: HomeEntity(name: "Salmoberry Trail", photoStatic: "sal", photoDynamic: "https://source.unsplash.com/random/1080x500", miles: 6), type: .dynamic)
}
