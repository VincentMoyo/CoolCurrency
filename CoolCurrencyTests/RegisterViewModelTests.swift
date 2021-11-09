//
//  RegisterViewModelTests.swift
//  CoolCurrencyTests
//
//  Created by Vincent Moyo on 2021/11/04.
//

import XCTest
@testable import CoolCurrency

class RegisterViewModelTests: XCTestCase {

    private var implementationUnderTests: RegisterViewModel!
    private var mockDelegate: MockDelegate!
    private var mockAuthenticationRepository: MockAuthenticationRepository!
    
    override func setUpWithError() throws {
        mockDelegate = MockDelegate()
        mockAuthenticationRepository = MockAuthenticationRepository()
        implementationUnderTests = RegisterViewModel(authenticationRepository: mockAuthenticationRepository,
                                                     delegate: mockDelegate)
    }
    
    func testAuthenticateUserSuccess() {
        implementationUnderTests.registerUser("abc@123.com", "password")
        XCTAssert(mockDelegate.refreshCalled)
    }
    
    func testAuthenticateUserFailure() {
        implementationUnderTests.registerUser("emailAlreadyExist", "password")
        XCTAssert(mockDelegate.showUserErrorCalled)
    }
    
    class MockDelegate: ViewModelDelegate {
        var refreshCalled = false
        var showUserErrorCalled = false
        
        func showUserErrorMessage(error: Error) { showUserErrorCalled = true }
        func bindViewModel() { refreshCalled = true }
    }
    
    class MockAuthenticationRepository: AuthenticationRepositable {
        func signOutUser(completion: @escaping (Result<Bool, Error>) -> Void) { completion(.success(true)) }
        func signedInUserIdentification() -> String { "" }
        var checkIfUserAlreadySignedIn: Bool {return true}
        func signInUser(_ email: String, _ password: String, completion: @escaping (Result<Bool, Error>) -> Void) { }
        func registerUser(_ email: String, _ password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
            if email == "emailAlreadyExist" {
                completion(.failure(MyErrors.retrieveError("error")))
            } else {
                completion(.success(true))
            }
        }
    }
}
