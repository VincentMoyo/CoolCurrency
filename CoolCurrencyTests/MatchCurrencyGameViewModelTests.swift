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
    private var mockDatabaseRepository: MockDatabaseRepository!
    
    override func setUpWithError() throws {
        mockDelegate = MockDelegate()
        mockDatabaseRepository = MockDatabaseRepository()
        implementationUnderTests = MatchCurrencyGameViewModel(databaseRepository: mockDatabaseRepository,
                                                              authenticationRepository: MockAuthenticationRepository(),
                                                              delegate: mockDelegate)
    }
    
    func setUpMock() {
        mockDatabaseRepository.response = .success(mockData)
        mockDatabaseRepository.userScoreResponse = .success(true)
        implementationUnderTests.loadUserSettingsFromDatabase()
    }
    
    private var mockData: [String: String] {
        ["FirstName": "Vincent",
         "Date of Birth": "1999-03-01",
         "LastName": "Moyo",
         "Gender": "Male"]
    }
    
    func testLoadUserSettingsFromDatabaseSuccess() {
        setUpMock()
        XCTAssert(mockDelegate.refreshCalled)
    }
    
    func testLoadUserSettingsFromDatabaseFailure() {
        implementationUnderTests.loadUserSettingsFromDatabase()
        XCTAssert(mockDelegate.showUserErrorCalled)
    }
    
    func testShouldDisplayFinalAnswer() {
        XCTAssertEqual(false, implementationUnderTests.shouldDisplayFinalAnswer())
    }
    
    func testCheckIfCorrectSuccess() {
        implementationUnderTests.selectedFlag = "SouthAfrica"
        implementationUnderTests.selectedSymbol = "SouthAfrica"
        XCTAssertEqual(true, implementationUnderTests.checkIfCorrect())
    }
    
    func testCheckIfCorrectFailure() {
        XCTAssertEqual(false, implementationUnderTests.checkIfCorrect())
    }
    
    func testRetrieveFirstName() {
        setUpMock()
        XCTAssertEqual("Vincent", implementationUnderTests.retrieveFirstName)
    }
    
    func testUserScoreListCountSuccess() {
        setUpMock()
        XCTAssertEqual("1", "\(implementationUnderTests.retrieveUserScoreListCount)")
        XCTAssert(mockDelegate.refreshCalled)
    }
    
    func testUserScoreListCountFailure() {
        implementationUnderTests.loadUserSettingsFromDatabase()
        XCTAssertEqual("0", "\(implementationUnderTests.retrieveUserScoreListCount)")
        XCTAssert(mockDelegate.showUserErrorCalled)
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
        
        var response: Result<[String: String], Error> = .failure(MyErrors.retrieveError("error"))
        
        var userScoreResponse: Result<Bool, Error> = .failure(MyErrors.retrieveError("error"))
        
        func updateUsersScoreboard(SignedInUser number: Int, name userName: String, finalScore userFinalScore: String, totalScore userTotalScore: String, completion: @escaping DatabaseResponse) {
            completion(userScoreResponse)
        }
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
        func retrieveUserScoreboards(completion: @escaping (Result<[LeadershipBoardDataModel], Error>) -> Void) {
            completion(.success([LeadershipBoardDataModel(userNumber: 0,
                                                          name: "Vincent",
                                                          correctAnswers: 6,
                                                          totalScore: 10)]))
        }
    }
}
