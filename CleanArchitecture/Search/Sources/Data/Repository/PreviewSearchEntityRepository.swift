//
//  
//  PreviewSearchEntityRepository.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 5/9/24.
//
//

import Foundation

public class PreviewMovieRepository: MovieRepositoryProtocol {
    
    var recents = [RecentEntity](arrayLiteral: RecentEntity(value: "Titanic"))
    
    public func searchMovies(with term: String) async throws -> [MovieEntity] {
        let movies = [
            MovieEntity(id: 1, title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic, 84 years later. A young Rose boards the ship with her mother and fiancé. Meanwhile, Jack Dawson and Fabrizio De Rossi win third-class tickets aboard the ship. Rose tells the whole story from Titanic's departure through to its death—on its first and last voyage—on April 15, 1912.", posterPath: "/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", rating: 6.2),
            MovieEntity(id: 2, title: "Fightclub", overview: "Unhappily married, Julia Sturges decides to go to America with her two children on the Titanic. Her husband, Richard also arranges passage on the luxury liner so as to have custody of their two children. All this fades to insignificance once the ship hits an iceberg.", posterPath: "/rEPzO9I6LCk6Mxg1X4BsBk6oA3V.jpg", rating: 6.5),
            MovieEntity(id: 3, title: "Titanic", overview: "This little-known German film retells the true story of the British ocean liner that met a tragic fate. Ernst Fritz Fürbringer plays the president of the White Star Line, who unwisely pressed the Titanic's captain (Otto Wernicke) to make the swiftest possible crossing to New York.", posterPath: "/Al7oIXQ4dZAofBTZWm6OiXS3MEa.jpg", rating: 7.8),
            MovieEntity(id: 4, title: "Titanic", overview: "", posterPath: "/yi73me6Jl3zDelS9pQK5jtMRhsc.jpg", rating: 7.0),
            MovieEntity(id: 5, title: "Diablo", overview: "Titatic is a Punjabi feature film. It is family movie. Titanic is based on a young boy's life whose dreams are so high. He wants to join Indian Navy. Unfortunately his life completely changed due to week financial conditions at home. He starts his work at low level driving of Autoriksha. He works so hard and he faces many obstacles in this work. At the end he accepted that his vehicle is submarine for him.", posterPath: "", rating: 8.1),
            MovieEntity(id: 6, title: "Sokea mies joka ei halunnut nähdä Titanicia", overview: "Jaakko and Sirpa have never met face to face, but talk on the phone every day. When Jaakko hears news about Sirpa's declining health, he decides to go meet her in another city. It's not the easiest decision, because he's blind and paralyzed from the chest down  - and he has to make the journey alone. To get there, Jaakko must rely on the help of five strangers. What could go wrong?", posterPath: "/lYuZ8yvVuUJsISKY75yt6FIzJFb.jpg", rating: 7.18)
        ]
        if term.isEmpty {
            return movies
        }
        return movies.filter { $0.title.contains(term) }
    }
    
    public func popularMovies(_ page: String) async throws -> [MovieEntity] {
        let movies = [
            MovieEntity(id: 1, title: "Godzilla Minus One", overview: "Postwar Japan is at its lowest point when a new crisis emerges in the form of a giant monster, baptized in the horrific power of the atomic bomb.", posterPath: "/hkxxMIGaiCTmrEArK7J56JTKUlB.jpg", rating: 7.7),
            MovieEntity(id: 2, title: "Kingdom of the Planet of the Apes", overview: "Several generations in the future following Caesar's reign, apes are now the dominant species and live harmoniously while humans have been reduced to living in the shadows. As a new tyrannical ape leader builds his empire, one young ape undertakes a harrowing journey that will cause him to question all that he has known about the past and to make choices that will define a future for apes and humans alike.", posterPath: "/gKkl37BQuKTanygYQG1pyYgLVgf.jpg", rating: 7.255),
            MovieEntity(id: 3, title: "Ghostbusters: Frozen Empire", overview: "After the original team developed a top-secret research laboratory to take the shattered ghosts to the next level. But when the discovery of an ancient artifact unleashes an evil force, both new and old must join forces to protect their homeland and save the world from the Second Ice Age... from the very thing that unleashes an unstoppable force from the depths of history. As chaos reigns and pure evil plunges the world into darkness, the Ghostbusters must step forward once again to save humanity from the brink of doom. With two generations of Ghostbusters fighting side by side, the stakes have never been higher. Will they be able to avert the inevitable before everything freezes?", posterPath: "/e1J2oNzSBdou01sUvriVuoYp0pJ.jpg", rating: 6.7),
            MovieEntity(id: 4, title: "Godzilla x Kong: The New Empire", overview: "", posterPath: "/tMefBSflR6PGQLv7WvFPpKLZkyk.jpg", rating: 7.0),
            MovieEntity(id: 5, title: "Abigail", overview: "Titatic is a Punjabi feature film. It is family movie. Titanic is based on a young boy's life whose dreams are so high. He wants to join Indian Navy. Unfortunately his life completely changed due to week financial conditions at home. He starts his work at low level driving of Autoriksha. He works so hard and he faces many obstacles in this work. At the end he accepted that his vehicle is submarine for him.", posterPath: "/7qxG0zyt29BI0IzFDfsps62kbQi.jpg", rating: 8.1),
            MovieEntity(id: 6, title: "Un père idéal", overview: "", posterPath: "/4xJd3uwtL1vCuZgEfEc8JXI9Uyx.jpg", rating: 7.18)
        ]
        return movies
    }
}

extension PreviewMovieRepository: SearchRepositoryProtocol {
    public func cleanRecentSearch() async throws {
        recents.removeAll()
    }
    
    
    public func getRecentsSearches() async throws -> [RecentEntity] {
                
        return recents
    }
    
    public func setRecentsSearch(value: String) async throws {
        
        recents.append(RecentEntity(value: value))
    }
}
