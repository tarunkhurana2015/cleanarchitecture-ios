//
//  
//  HomeRepository.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 5/9/24.
//
//

import Foundation

public struct HomeRepository: HomeRepositoryProtocol {
    public func fetchHome() async throws -> [HomeEntity] {
        throw HomeError.dataNotFound
    }
}
