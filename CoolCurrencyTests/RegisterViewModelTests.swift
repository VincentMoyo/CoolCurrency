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
                                                     delegate: mockDelegate, database: MockDatabaseRepository())
    }
    
    func testAuthenticateUserSuccess() {
        implementationUnderTests.registerUser("abc@123.com", "password")
        XCTAssert(mockDelegate.refreshCalled)
    }
    
    func testAuthenticateUserFailure() {
        implementationUnderTests.registerUser("emailAlreadyExist", "password")
        XCTAssert(mockDelegate.showUserErrorCalled)
    }
    
    class MockDelegate: AuthenticationViewModelDelegate {
        var refreshCalled = false
        var showUserErrorCalled = false
        
        func showUserErrorMessage(error: Error) { showUserErrorCalled = true }
        func stopActivityLoader() { refreshCalled = true }
        func bindViewModel() { refreshCalled = true }
    }
    
    class MockDatabaseRepository: DatabaseRepositable {
        func updateUsersScoreboard(SignedInUser number: Int, name userName: String, finalScore userFinalScore: String, totalScore userTotalScore: String, completion: @escaping DatabaseResponse) { }
        func retrieveUserScoreboards(completion: @escaping (Result<[LeadershipBoardDataModel], Error>) -> Void) { }
        func retrieveCurrencyFromDatabase(baseCurrency: String, completion: @escaping CurrencyFromDatabaseResponse) { }
        func retrieveUserInformationFromDatabase(userID baseUser: String, completion: @escaping UserInformationFromDatabaseResponse) { }
        func updateFirstNameUserInformationToDatabase(SignedInUser userSettingsID: String, username firstName: String, completion: @escaping DatabaseResponse) { }
        func updateLastNameUserInformationToDatabase(SignedInUser userSettingsID: String, userLastName lastName: String, completion: @escaping DatabaseResponse) { }
        func updateUserSettingsGender(SignedInUser userSettingsID: String, userGender gender: String, completion: @escaping DatabaseResponse) { }
        func updateUserSettingsDateOfBirth(SignedInUser userSettingsID: String, DOB: String, completion: @escaping DatabaseResponse) { }
        func updateDefaultCurrencyInformationToDatabase(SignedInUser userSettingsID: String, currency defaultCurrency: String, completion: @escaping DatabaseResponse) { }
        func updateMeasurementUnitToDatabase(SignedInUser userSettingsID: String, measurementUnit unit: String, completion: @escaping DatabaseResponse) { }
        func insertCurrencyIntoDatabase(for baseCurrency: String, with currencyList: [String: Double], completion: @escaping DatabaseResponse) { }
        func createNewUserSettings(SignedInUser userSettingsID: String, completion: @escaping DatabaseResponse) { completion(.success(true)) }
        func insertProfilePictureIntoDatabase(SignedInUser userSettingsID: String, forImage imageData: Data, completion: @escaping DatabaseResponse) { }
        func performProfilePictureRequest(for urlString: String, completion: @escaping ProfilePictureResponse) { }
    }
    
    class MockAuthenticationRepository: AuthenticationRepositable {
        var checkIfUserAlreadySignedIn: Bool {return true}
        
        func resetEmailToDatabase(newEmail email: String, completion: @escaping DatabaseResponse) { }
        func signOutUser(completion: @escaping (Result<Bool, Error>) -> Void) { completion(.success(true)) }
        func signedInUserIdentification() -> String { "" }
        func signInUser(_ email: String, _ password: String, completion: @escaping (Result<Bool, Error>) -> Void) { }
        func registerUser(_ email: String, _ password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
            email == "emailAlreadyExist" ? completion(.failure(MyErrors.retrieveError("error"))) : completion(.success(true))
        }
    }
}
