//
//  
//  SearchEntity.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 5/9/24.
//
//

import Foundation

public struct MoviesResult: Codable {
    let results: [MovieEntity]
}

public struct MovieEntity: Codable {
    
    public let id: Int
    public let title: String
    public let overview: String
    public let posterUrl: URL?
    public let rating: Double
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        overview = try values.decode(String.self, forKey: .overview)
        let posterPath = (try? values.decode(String.self, forKey: .posterUrl)) ?? ""
        posterUrl = posterPath.isEmpty ? nil : MovieImgeURLFactory().makeImageURL(imagePath: posterPath)
        rating = try values.decode(Double.self, forKey: .rating)
    }
    
    init(id: Int, title: String, overview: String, posterPath: String, rating: Double) {
        self.id = id
        self.title = title
        self.overview = overview
        self.posterUrl = MovieImgeURLFactory().makeImageURL(imagePath: posterPath)
        self.rating = rating
        
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterUrl = "poster_path"
        case rating = "vote_average"
    }
}
