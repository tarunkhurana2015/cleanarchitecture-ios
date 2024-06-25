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
import Storage
import CoreData

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
    
    static var liveValue: NetworkSession = DefaultNetworkSession(config: NetworkConfig(baseUrl: URL(string: MovieAPI.baseURL)!, headers: [:], queryParams: [:]))

}
extension DependencyValues {
    public var networkSession: NetworkSession {
        get { self[NetworkSessionKey.self] }
        set { self[NetworkSessionKey.self] = newValue }
    }
}

struct StorageKey: DependencyKey {
    static var liveValue: CoreDataStack?  {
        guard let path = Bundle.module.url(forResource: "Search", withExtension: "momd"),
                let model = NSManagedObjectModel(contentsOf: path) else {
            fatalError("Model doesnot exists")
        }
        return CoreDataStack(managedObjectModel: model, "SearchContainer")
    }
    static var previewValue: CoreDataStack? {
        guard let path = Bundle.module.url(forResource: "Search", withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: path) else {
            fatalError("Model doesnot exits")
        }
        return CoreDataStack(managedObjectModel: model, "PreviewContainer", inMemory: true)
    }
}
extension DependencyValues {
    public var coreDataStack: CoreDataStack? {
        get { self[StorageKey.self] }
        set { self[StorageKey.self] = newValue}
    }
}
