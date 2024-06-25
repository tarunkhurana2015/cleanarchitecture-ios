//
//  File.swift
//  
//
//  Created by Tarun Khurana on 5/10/24.
//

import Foundation

public struct MovieImgeURLFactory: MovieImgeURLFactoryProtocol {
    public func makeImageURL(imagePath: String) -> URL? {
        
        return URL(string: MovieAPI.baseImageURL + "/" + imagePath + "?" + "api_key=" + MovieAPI.apiKey)
    }
}
