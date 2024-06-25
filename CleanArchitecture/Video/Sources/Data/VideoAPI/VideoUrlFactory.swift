//
//  File.swift
//  
//
//  Created by Tarun Khurana on 6/11/24.
//

import Foundation

public struct VideoUrlFactory: VideoUrlFactoryProtocol {
    func makeVideoUrl() -> URL? {
        return URL(string: VideoAPI.baseUrl + "/" + VideoAPI.basePath + "/" + VideoAPI.apiKey + "/" + VideoAPI.moviesFile)
    }
    
    func makeImageUrl(_ imagePath: String) -> URL? {
        return URL(string: VideoAPI.imageBaseUrl + "/" + imagePath)
    }
}
