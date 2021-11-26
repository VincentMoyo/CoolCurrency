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
    
    func testSignOutCurrentUserSuccess() {
        setUpMockResponse()
        implementationUnderTests.signOutCurrentUser()
        XCTAssert(mockDelegate.signOutCalled)
    }
    
    func testSignOutCurrentUserFailure() {
        mockAuthenticationRepository.signOutSuccess = false
        implementationUnderTests.signOutCurrentUser()
        XCTAssert(mockDelegate.showUserErrorCalled)
    }
    
    func testCheckListFirstName() {
        setUpMockResponse()
        XCTAssertEqual(implementationUnderTests.retrieveFirstName, "Vincent")
        XCTAssert(mockDelegate.refreshCalled)
    }
    
    func testCheckListLastName() {
        setUpMockResponse()
        XCTAssertEqual(implementationUnderTests.retrieveLastName, "Moyo")
        XCTAssert(mockDelegate.refreshCalled)
    }
    
    func testCheckListGenderIsMaleSuccess() {
        setUpMockResponse()
        XCTAssertEqual(implementationUnderTests.retrieveGender, 1)
        XCTAssert(mockDelegate.refreshCalled)
    }
    
    func testResetEmailSuccess() {
        setUpMockResponse()
        implementationUnderTests.resetEmail(newEmail: "Vince@sam.com")
        XCTAssert(mockDelegate.refreshCalled)
    }
    
    func testResetEmailWithoutComKeywordFailure() {
        setUpMockResponse()
        implementationUnderTests.resetEmail(newEmail: "Vince@sam")
        XCTAssert(mockDelegate.showUserErrorCalled)
    }
    
    func testResetEmailWithoutAtKeywordFailure() {
        setUpMockResponse()
        implementationUnderTests.resetEmail(newEmail: "Vince.com")
        XCTAssert(mockDelegate.showUserErrorCalled)
    }
    
    private func setUpMockResponse() {
        mockDatabaseRepository.response = .success(mockData)
        implementationUnderTests.loadUserSettingsFromDatabase()
    }
    
    private var mockData: [String: String] {
        ["FirstName": "Vincent",
         "Date of Birth": "1999-03-01",
         "LastName": "Moyo",
         "Gender": "Male"]
    }
    
    class MockDelegate: SettingsViewModelDelegate {
        var refreshCalled = false
        var showUserErrorCalled = false
        var signOutCalled = false
        
        func showUserErrorMessage(error: Error) { showUserErrorCalled = true }
        func bindViewModel() { refreshCalled = true }
        func signOutBindViewModel() { signOutCalled = true }
    }
    
    class MockAuthenticationRepository: AuthenticationRepositable {
        var signOutSuccess = true
        
        var errorResponse: Result<Bool, Error> = .failure(MyErrors.retrieveError("error"))
        func registerUser(_ email: String, _ password: String, completion: @escaping DatabaseResponse) { }
        func resetEmailToDatabase(newEmail email: String, completion: @escaping DatabaseResponse) {
            email.contains(".com") && email.contains("@") == true ? completion(.success(true)) : completion(errorResponse)
        }
        func signInUser(_ email: String, _ password: String, completion: @escaping DatabaseResponse) { }
        func signOutUser(completion: @escaping DatabaseResponse) {
            signOutSuccess == true ? completion(.success(true)) : completion(errorResponse)
        }
        func signedInUserIdentification() -> String { "" }
        var checkIfUserAlreadySignedIn: Bool { return true }
    }
    
    class MockDatabaseRepository: DatabaseRepositable {
        
        func updateUsersScoreboard(SignedInUser number: Int, name userName: String, finalScore userFinalScore: String, totalScore userTotalScore: String, completion: @escaping DatabaseResponse) {
            
        }
        
        func retrieveUserScoreboards(completion: @escaping (Result<[LeadershipBoardDataModel], Error>) -> Void) {
            
        }
        
        var response: Result<[String: String], Error> = .failure(MyErrors.retrieveError("error"))
        
        func retrieveCurrencyFromDatabase(baseCurrency: String, completion: @escaping CurrencyFromDatabaseResponse) { }
        func updateFirstNameUserInformationToDatabase(SignedInUser userSettingsID: String, username firstName: String, completion: @escaping DatabaseResponse) { }
        func updateLastNameUserInformationToDatabase(SignedInUser userSettingsID: String, userLastName lastName: String, completion: @escaping DatabaseResponse) { }
        func updateUserSettingsGender(SignedInUser userSettingsID: String, userGender gender: String, completion: @escaping DatabaseResponse) { }
        func updateUserSettingsDateOfBirth(SignedInUser userSettingsID: String, DOB: String, completion: @escaping DatabaseResponse) { }
        func updateDefaultCurrencyInformationToDatabase(SignedInUser userSettingsID: String, currency defaultCurrency: String, completion: @escaping DatabaseResponse) { }
        func updateMeasurementUnitToDatabase(SignedInUser userSettingsID: String, measurementUnit unit: String, completion: @escaping DatabaseResponse) { }
        func insertCurrencyIntoDatabase(for baseCurrency: String, with currencyList: [String: Double], completion: @escaping DatabaseResponse) { }
        func createNewUserSettings(SignedInUser userSettingsID: String, completion: @escaping DatabaseResponse) { }
        func insertProfilePictureIntoDatabase(SignedInUser userSettingsID: String, forImage imageData: Data, completion: @escaping DatabaseResponse) { }
        func performProfilePictureRequest(for urlString: String, completion: @escaping ProfilePictureResponse) { }
        func updateUserSettingsGender(SignedInUser userSettingsID: String, userGender gender: String) { }
        func updateUserSettingsDateOfBirth(SignedInUser userSettingsID: String, DOB: String) { }
        func retrieveUserInformationFromDatabase(userID baseUser: String, completion: @escaping (Result<[String: String], Error>) -> Void) {
            completion(response)
        }
    }
}
