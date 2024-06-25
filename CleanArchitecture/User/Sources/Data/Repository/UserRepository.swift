//
//  File.swift
//  
//
//  Created by Tarun Khurana on 4/27/24.
//

import Foundation
import Dependencies
import Networking
import Authentication

public struct UserRepository: UserRepositoryProtocol {
    
    @Dependency(\.networkSession) var networkSession
    @Dependency(\.authRequestFactory) var authRequestFactory
    @Dependency(\.authSession) var authSession
    
    public func signUp<Entity: Decodable>(_ username: String, email: String, password: String) async throws -> Entity {
        do {
            guard let request = await authRequestFactory.makeSignUpRequest(username, email: email, password: password) else {
                throw UserError.requestNotFormed
            }
            let data = try await networkSession.request(request)
            let decoder = JSONDecoder()
            let entity = try decoder.decode(Entity.self, from: data)
            return entity
        } catch {
            throw error
        }
    }
    
    public func signIn<Entity: Decodable>(_ email: String, password: String) async throws -> Entity {
        do {
            guard let request = await authRequestFactory.makeSignInRequest(email, password: password) else {
                throw UserError.requestNotFormed
            }
            let data = try await networkSession.request(request)
            let decoder = JSONDecoder()
            let entity = try decoder.decode(Entity.self, from: data)
            return entity
        } catch {
            throw error
        }
    }
    
    public func saveToken(_ token: String) async -> Bool {
        return await authSession.updateToken(token)
    }
    
    public func validateToken(_ token: String) async -> Bool {
        do {
            guard let request = await authRequestFactory.validateTokenRequest(token) else {
                return false
            }
            let _ = try await networkSession.request(request)
            return true
        } catch {
            return false
        }
    }
    
    public func fetchToken() async -> String {
        return await authSession.getToken()
    }
}
