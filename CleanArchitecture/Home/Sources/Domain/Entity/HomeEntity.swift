//
//  
//  HomeEntity.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 5/9/24.
//
//

import Foundation

public struct HomeEntity: Codable, Equatable, Hashable, Identifiable {
    
    public var id = UUID()
    
    let name: String
    let photoStatic: String
    let photoDynamic: String
    let miles: Double
}
