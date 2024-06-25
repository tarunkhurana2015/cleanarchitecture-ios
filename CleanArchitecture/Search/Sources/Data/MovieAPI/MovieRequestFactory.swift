//
//  File.swift
//  
//
//  Created by Tarun Khurana on 5/10/24.
//

import Foundation
import Networking

protocol MovieRequestFactoryProtocol {
    func makeMoviesRequest(_ searchTerm: String) async -> Requestable?
    func makePopularMoviesRequest(_ page: String) async -> Requestable?
}

struct MovieRequestFactory: MovieRequestFactoryProtocol {
    func makeMoviesRequest(_ searchTerm: String) async -> Requestable? {
        return Request(path: MovieAPI.searchPath,
                       method: .get,
                       headerParameters: ["Content-Type": "application/json"],
                       queryParameters: ["api_key":MovieAPI.apiKey, "query": searchTerm])
    }
    
    func makePopularMoviesRequest(_ page: String) async -> Requestable? {
        return Request(path: MovieAPI.popularPath,
                       method: .get,
                       headerParameters: ["Content-Type": "application/json"],
                       queryParameters: ["api_key":MovieAPI.apiKey, "page": page])
    }
}
