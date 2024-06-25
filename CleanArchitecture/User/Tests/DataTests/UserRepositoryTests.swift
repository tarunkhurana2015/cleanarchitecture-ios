//
//  UserRepositoryTests.swift
//  
//
//  Created by Tarun Khurana on 4/29/24.
//

import XCTest
@testable import User
import Dependencies


final class UserRepositoryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_signUp_Success() async throws {
        // Given
        @Dependency(\.userRepository) var userRepository
        
        // When
        do {
            let entity = try await userRepository.signUp("username", email: "email", password: "password")
            XCTAssert(entity.userId == "123456")
            XCTAssert(entity.username == "username")
            XCTAssert(entity.token == "abcdef")
        } catch {
            
        }
    }

}
