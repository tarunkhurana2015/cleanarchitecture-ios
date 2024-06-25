//
//  File.swift
//  
//
//  Created by Tarun Khurana on 5/20/24.
//

import Foundation

public protocol SearchRepositoryProtocol {
    func getRecentsSearches() async throws -> [RecentEntity]
    func setRecentsSearch(value: String) async throws
    func cleanRecentSearch() async throws
}
