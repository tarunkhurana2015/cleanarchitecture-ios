//
//  
//  PreviewHomeEntityRepository.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 5/9/24.
//
//

import Foundation

public struct PreviewHomeRepository: HomeRepositoryProtocol {
    public func fetchHome() async throws -> [HomeEntity] {
        let entities = [
            HomeEntity(name: "Salmoberry Trail", photoStatic: "sal", photoDynamic: "https://source.unsplash.com/random/1080x500", miles: 6),
            HomeEntity(name: "Angel Fire", photoStatic: "angel", photoDynamic: "https://source.unsplash.com/random/1080x500", miles: 9.1),
            HomeEntity(name: "RainDeer Trail", photoStatic: "rain", photoDynamic: "https://source.unsplash.com/random/1080x500", miles: 20.8)
        ]
        return entities
    }
}
