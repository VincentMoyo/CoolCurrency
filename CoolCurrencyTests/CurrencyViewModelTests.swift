//
//  CurrencyViewModelTest.swift
//  CoolCurrencyTests
//
//  Created by Vincent Moyo on 2021/10/11.
//

import XCTest
@testable import CoolCurrency

class CurrencyViewModelTests: XCTestCase {
    
    private var implementationUnderTests: CurrencyViewModel!
    private var mockDelegate: MockDelegate!
    private var mockRepository: MockRepository!
    
    override func setUp() {
        mockDelegate = MockDelegate()
        mockRepository = MockRepository()
        implementationUnderTests = CurrencyViewModel(repository: mockRepository,
                                                     authentication: MockAuthenticationRepository(),
                                                     database: MockDatabaseRepository(),
                                                     delegate: mockDelegate)
    }
    
    func testFetchCurrencySuccess() {
        setUpMockResponse()
        XCTAssertEqual(14, implementationUnderTests.currencyList.values.count)
        XCTAssert(mockDelegate.refreshCalled)
    }
    
    func testFetchCurrencyFailure() {
        implementationUnderTests.fetchCurrencyListFromAPI(for: "ZAR")
        XCTAssert(mockDelegate.showUserErrorCalled)
    }
    
    func testConvertCurrencyToCodeSuccess() {
        XCTAssertEqual("ZAR", implementationUnderTests.convertCurrencyToCode(for: "Rand"))
    }
    
    func testCurrencyModelReturnsCorrectValue() {
        setUpMockResponse()
        XCTAssertEqual("Rand", implementationUnderTests.currencyDataModel(at: 1)?.currencyName)
    }
    
    func setUpMockResponse() {
        mockRepository.response = .success(mockData)
        implementationUnderTests.fetchCurrencyListFromAPI(for: "ZAR")
    }
    
    private var mockData: CurrencyResponseModel {
        CurrencyResponseModel(response: Response(base: "ZAR",
                                                 rates: Rates(unitedStatesDollar: 1.1,
                                                              euro: 1.1,
                                                              indianRupee: 1.1,
                                                              bostwanaPula: 1.1,
                                                              canadianDollar: 1.1,
                                                              ghanaCedi: 1.1,
                                                              greatBritishPound: 1.1,
                                                              japaneseYen: 1.1,
                                                              russianRuble: 1.1,
                                                              chineseYuan: 1.1,
                                                              southAfricanRand: 1.1,
                                                              unitedArabDirham: 1.1,
                                                              brazilianReal: 1.1,
                                                              australianDollar: 1.1)))
    }
    
    class MockDelegate: ViewModelDelegate {
        var refreshCalled = false
        var showUserErrorCalled = false
        
        func showUserErrorMessage(error: Error) { showUserErrorCalled = true }
        func bindViewModel() { refreshCalled = true }
    }
    
    class MockRepository: CurrencyRepositable {
        var response: Result<CurrencyResponseModel, Error> = .failure(MyErrors.retrieveError("error"))
        
        func performCurrencyRequest(for baseCurrency: String, completion: @escaping ListCurrencyResponseModel) { completion(response) }
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
        func retrieveUserInformationFromDatabase(userID baseUser: String, completion: @escaping (Result<[String: String], Error>) -> Void) { }
        func updateUsersScoreboard(SignedInUser number: Int, name userName: String, finalScore userFinalScore: String, totalScore userTotalScore: String, completion: @escaping DatabaseResponse) { }
        func retrieveUserScoreboards(completion: @escaping (Result<[LeadershipBoardDataModel], Error>) -> Void) { }
    }
}
