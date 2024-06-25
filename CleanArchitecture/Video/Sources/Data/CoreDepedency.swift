//
//  File.swift
//  
//
//  Created by Tarun Khurana on 5/9/24.
//

import Foundation
import Dependencies
import Networking
import Authentication

struct NetworkURLSessionKey: DependencyKey {
    
    static var liveValue: any NetworkURLSession = DefaultNetworkURLSession()    

}
extension DependencyValues {
    public var networkURLSession: NetworkURLSession {
        get { self[NetworkURLSessionKey.self] }
        set { self[NetworkURLSessionKey.self] = newValue }
    }
}
