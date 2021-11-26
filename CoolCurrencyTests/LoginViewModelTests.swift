//
//  LoginViewModelTests.swift
//  CoolCurrencyTests
//
//  Created by Vincent Moyo on 2021/11/04.
//

import XCTest
@testable import CoolCurrency

class LoginViewModelTests: XCTestCase {

    private var implementationUnderTests: LoginViewModel!
    private var mockDelegate: MockDelegate!
    private var mockAuthenticationRepository: MockAuthenticationRepository!
    
    override func setUpWithError() throws {
        mockDelegate = MockDelegate()
        mockAuthenticationRepository = MockAuthenticationRepository()
        implementationUnderTests = LoginViewModel(authenticationRepository: mockAuthenticationRepository,
                                                     delegate: mockDelegate)
    }
    
    func testAuthenticateUserSuccess() {
        implementationUnderTests.authenticateUser("abc@123.com", "correctPassword")
        XCTAssert(mockDelegate.refreshCalled)
    }
    
    func testAuthenticateUserFailure() {
        implementationUnderTests.authenticateUser("abc@123.com", "wrongPassword")
        XCTAssert(mockDelegate.showUserErrorCalled)
    }
    
    class MockDelegate: AuthenticationViewModelDelegate {
        var refreshCalled = false
        var showUserErrorCalled = false
        
        func showUserErrorMessage(error: Error) { showUserErrorCalled = true }
        func stopActivityLoader() { refreshCalled = true }
        func bindViewModel() { refreshCalled = true }
    }
    
    class MockAuthenticationRepository: AuthenticationRepositable {
        var checkIfUserAlreadySignedIn: Bool {return true}
        
        func resetEmailToDatabase(newEmail email: String, completion: @escaping DatabaseResponse) { }
        func registerUser(_ email: String, _ password: String, completion: @escaping (Result<Bool, Error>) -> Void) { }
        func signOutUser(completion: @escaping (Result<Bool, Error>) -> Void) { completion(.success(true)) }
        func signedInUserIdentification() -> String { "" }
        func signInUser(_ email: String, _ password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
            password == "correctPassword" ?  completion(.success(true)) : completion(.failure(MyErrors.retrieveError("error")))
        }
    }
}
