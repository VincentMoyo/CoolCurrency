//
//  SettingViewModelTests.swift
//  CoolCurrencyTests
//
//  Created by Vincent Moyo on 2021/11/03.
//

import XCTest
@testable import CoolCurrency

class SettingViewModelTests: XCTestCase {
    
    private var implementationUnderTests: SettingsViewModel!
    private var mockDelegate: MockDelegate!
    private var mockDatabaseRepository: MockDatabaseRepository!
    private var mockAuthenticationRepository: MockAuthenticationRepository!
    
    override func setUpWithError() throws {
        mockDelegate = MockDelegate()
        mockDatabaseRepository = MockDatabaseRepository()
        mockAuthenticationRepository = MockAuthenticationRepository()
        implementationUnderTests = SettingsViewModel(databaseRepository: mockDatabaseRepository,
                                                     authenticationRepository: mockAuthenticationRepository,
                                                     delegate: mockDelegate)
    }
    
    func testCheckList() {
        setUpMockResponse()
        XCTAssertEqual(implementationUnderTests.firstName, "Nkosi")
        XCTAssert(mockDelegate.refreshCalled)
    }
    
    func setUpMockResponse() {
        mockDatabaseRepository.response = .success(mockData)
        implementationUnderTests.loadUserSettingsFromDatabase()
        implementationUnderTests.checkUserList()
    }
    
    private var mockData: [String: String] {
        ["FirstName": "Nkosi",
         "Date of Birth": "1999-03-01",
         "LastName": "Moyo",
         "Gender": "Male"]
    }
    
    class MockDelegate: SettingsViewModelDelegate {
        
        var refreshCalled = false
        var showUserErrorCalled = false
        var signOutCalled = false
        
        func showUserErrorMessage(error: Error) {
            showUserErrorCalled = true
        }
        
        func bindViewModel() {
            refreshCalled = true
        }
        
        func signOutBindViewModel() {
            signOutCalled = true
        }
    }
    
    class MockAuthenticationRepository: AuthenticationRepositable {
        func registerUser(_ email: String, _ password: String, completion: @escaping (Result<Bool, Error>) -> Void) { }
        func signInUser(_ email: String, _ password: String, completion: @escaping (Result<Bool, Error>) -> Void) { }
        func signOutUser(completion: @escaping (Result<Bool, Error>) -> Void) { }
        func signedInUserIdentification() -> String { "" }
        var checkIfUserAlreadySignedIn: Bool {return true}
    }
    
    class MockDatabaseRepository: DatabaseRepositable {
        var response: Result<[String: String], Error> = .failure(MyErrors.retrieveError("error"))
        func retrieveCurrencyFromDatabase(baseCurrency: String, completion: @escaping (Result<[String: Double], Error>) -> Void) { }
        func updateFirstNameUserInformationToDatabase(SignedInUser userSettingsID: String, username firstName: String) { }
        func updateLastNameUserInformationToDatabase(SignedInUser userSettingsID: String, userLastName lastName: String) { }
        func updateUserSettingsGender(SignedInUser userSettingsID: String, userGender gender: String) { }
        func updateUserSettingsDateOfBirth(SignedInUser userSettingsID: String, DOB: String) { }
        func retrieveUserInformationFromDatabase(userID baseUser: String, completion: @escaping (Result<[String: String], Error>) -> Void) {
            completion(response)
            
        }
    }
}
