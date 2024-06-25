//
//  
//  HomeRepositortyProtocol.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 5/9/24.
//
//

import Foundation

public protocol HomeRepositoryProtocol {
    func fetchHome() async throws -> [HomeEntity]
}
