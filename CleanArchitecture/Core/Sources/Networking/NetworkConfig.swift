//
//  File.swift
//  
//
//  Created by Tarun Khurana on 4/28/24.
//

import Foundation

public protocol NetworkConfigurable {
    var baseUrl: URL { get }
    var headers: [String: String] { get }
    var queryParams: [String: String] { get }
}

public struct NetworkConfig: NetworkConfigurable {
    public var baseUrl: URL
    public var headers: [String : String]
    public var queryParams: [String : String]
    
    public init(baseUrl: URL, headers: [String : String], queryParams: [String : String]) {
        self.baseUrl = baseUrl
        self.headers = headers
        self.queryParams = queryParams
    }
}
