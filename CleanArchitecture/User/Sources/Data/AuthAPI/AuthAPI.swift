//
//  File.swift
//  
//
//  Created by Tarun Khurana on 4/28/24.
//

import Foundation

enum AuthAPI {
    static let baseURL = "http://localhost:8000"
    static let basePath = "auth"
    
    static let signIn = "/signin"
    static let signUp = "/signup"
    static let validate = "/validToken"
}


