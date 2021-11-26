//
//  MatchCurrencyGameViewModelTests.swift
//  CoolCurrencyTests
//
//  Created by Vincent Moyo on 2021/11/25.
//

import XCTest
@testable import CoolCurrency

class MatchCurrencyGameViewModelTests: XCTestCase {

    private var implementationUnderTests: MatchCurrencyGameViewModel!
    private var mockDelegate: MockDelegate!
    
    override func setUpWithError() throws {
        mockDelegate = MockDelegate()
        implementationUnderTests = MatchCurrencyGameViewModel(databaseRepository: MockDatabaseRepository(),
                                                              authenticationRepository: MockAuthenticationRepository(),
                                                              delegate: mockDelegate)
    }
    
    class MockDelegate: ViewModelDelegate {
        var refreshCalled = false
        var showUserErrorCalled = false
        
        func showUserErrorMessage(error: Error) { showUserErrorCalled = true }
        func bindViewModel() { refreshCalled = true }
    }
    
    class MockAuthenticationRepository: AuthenticationRepositable {
        var signOutSuccess = true
        
        var errorResponse: Result<Bool, Error> = .failure(MyErrors.retrieveError("error"))
        func registerUser(_ email: String, _ password: String, completion: @escaping DatabaseResponse) { }
        func resetEmailToDatabase(newEmail email: String, completion: @escaping DatabaseResponse) { }
        func signInUser(_ email: String, _ password: String, completion: @escaping DatabaseResponse) { }
        func signOutUser(completion: @escaping DatabaseResponse) { }
        func signedInUserIdentification() -> String { "" }
        var checkIfUserAlreadySignedIn: Bool {return true}
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
        func retrieveUserInformationFromDatabase(userID baseUser: String, completion: @escaping (Result<[String: String], Error>) -> Void) { completion(response) }
    }
}
