//
//  
//  VideoEntity.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 6/11/24.
//
//

import Foundation

public struct VideoResponse: Decodable {
    
    let categories: [VideoCategory]
}

public struct VideoCategory: Decodable {
    let name: String
    let videos: [VideoEntity]
}

public struct VideoEntity: Decodable {
    let id = UUID()
    let title: String
    let detail: String
    let subtitle: String
    let thumb: String
    let sources: [String]
    
    enum CodingKeys: String, CodingKey {
        case title
        case detail = "description"
        case subtitle
        case thumb
        case sources
    }
}


