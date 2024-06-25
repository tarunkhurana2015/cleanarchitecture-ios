//
//  SignInViewReducerlTests.swift
//  
//
//  Created by Tarun Khurana on 4/29/24.
//

import XCTest
@testable import User
import Dependencies
import ComposableArchitecture

final class SignInViewReducerlTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_signIn_Success() async {
        // When
        let store = TestStore(initialState: SignInViewReducer.State()) {
            SignInViewReducer()
        }
        
        // Given
//        await store.send(.signInButtonTapped("email", password: "password")) {state in 
//            state.loginState
//        }
        
        // Then
        
    }

}
