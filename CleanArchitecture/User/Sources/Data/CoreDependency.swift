//
//  File.swift
//  
//
//  Created by Tarun Khurana on 4/28/24.
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


struct NetworkSessionKey: DependencyKey {
    
    static var liveValue: NetworkSession = DefaultNetworkSession(config: NetworkConfig(baseUrl: URL(string: AuthAPI.baseURL)!, headers: [:], queryParams: [:]))

}
extension DependencyValues {
    public var networkSession: NetworkSession {
        get { self[NetworkSessionKey.self] }
        set { self[NetworkSessionKey.self] = newValue }
    }
}

struct AuthRequestFactoryKey: DependencyKey {
    static var liveValue: AuthRequestFactoryProtocol = AuthRequestFactory()
}
extension DependencyValues {
    var authRequestFactory: AuthRequestFactoryProtocol {
        get { self[AuthRequestFactoryKey.self] }
        set { self[AuthRequestFactoryKey.self] = newValue }
    }
}

struct AuthSessionKey: DependencyKey {
    
    static var liveValue: AuthSession = AuthSession()

}
extension DependencyValues {
    public var authSession: AuthSession {
        get { self[AuthSessionKey.self] }
        set { self[AuthSessionKey.self] = newValue }
    }
}
