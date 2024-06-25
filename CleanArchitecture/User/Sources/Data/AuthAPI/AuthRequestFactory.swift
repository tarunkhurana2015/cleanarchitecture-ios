//
//  File.swift
//  
//
//  Created by Tarun Khurana on 4/28/24.
//

import Foundation
import Networking

protocol AuthRequestFactoryProtocol {
    func makeSignInRequest(_ email: String, password: String) async -> Requestable?
    func makeSignUpRequest(_ username: String, email: String, password: String) async -> Requestable?
    func validateTokenRequest(_ token: String) async -> Requestable?
}

struct AuthRequestFactory: AuthRequestFactoryProtocol {
    func makeSignInRequest(_ email: String, password: String) async -> Requestable? {
        return Request(path: AuthAPI.basePath + AuthAPI.signIn,
                       method: .post,
                       headerParameters: ["Content-Type": "application/json"],
                       bodyParameters: ["email": email, "password": password])
    }
    func makeSignUpRequest(_ username: String, email: String, password: String) async -> Requestable? {
        return Request(path: AuthAPI.basePath + AuthAPI.signUp, method: .post)
    }
    func validateTokenRequest(_ token: String) async -> Requestable? {
        return Request(path: AuthAPI.basePath + AuthAPI.validate,
                       method: .get,
                       headerParameters: ["Authorization": "Bearer \(token)"])
    }
}
