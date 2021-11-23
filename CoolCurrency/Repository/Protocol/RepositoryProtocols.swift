//
//  CurrencyRepositable.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/06.
//

import Foundation

typealias ListCurrencyResponseModel = (Result<CurrencyResponseModel, Error>) -> Void
typealias DatabaseResponse = (Result<Bool, Error>) -> Void
typealias CurrencyFromDatabaseResponse = (Result<[String: Double], Error>) -> Void
typealias UserInformationFromDatabaseResponse = (Result<[String: String], Error>) -> Void
typealias ProfilePictureResponse = (Result<Data, Error>) -> Void

protocol CurrencyRepositable {
    func performCurrencyRequest(for baseCurrency: String, completion: @escaping ListCurrencyResponseModel)
}

protocol AuthenticationRepositable {
    func registerUser(_ email: String, _ password: String, completion: @escaping DatabaseResponse)
    func signInUser(_ email: String, _ password: String, completion: @escaping DatabaseResponse)
    func resetEmailToDatabase(newEmail email: String, completion: @escaping DatabaseResponse)
    func signOutUser(completion: @escaping DatabaseResponse)
    func signedInUserIdentification() -> String
    var checkIfUserAlreadySignedIn: Bool { get }
}

protocol DatabaseRepositable {
    func retrieveCurrencyFromDatabase(baseCurrency: String, completion: @escaping CurrencyFromDatabaseResponse)
    func retrieveUserInformationFromDatabase(userID baseUser: String, completion: @escaping UserInformationFromDatabaseResponse)
    func updateFirstNameUserInformationToDatabase(SignedInUser userSettingsID: String, username firstName: String, completion: @escaping DatabaseResponse)
    func updateLastNameUserInformationToDatabase(SignedInUser userSettingsID: String, userLastName lastName: String, completion: @escaping DatabaseResponse)
    func updateUserSettingsGender(SignedInUser userSettingsID: String, userGender gender: String, completion: @escaping DatabaseResponse)
    func updateUserSettingsDateOfBirth(SignedInUser userSettingsID: String, DOB: String, completion: @escaping DatabaseResponse)
    func updateDefaultCurrencyInformationToDatabase(SignedInUser userSettingsID: String, currency defaultCurrency: String, completion: @escaping DatabaseResponse)
    func updateMeasurementUnitToDatabase(SignedInUser userSettingsID: String, measurementUnit unit: String, completion: @escaping DatabaseResponse)
    func insertCurrencyIntoDatabase(for baseCurrency: String, with currencyList: [String: Double], completion: @escaping DatabaseResponse)
    func createNewUserSettings(SignedInUser userSettingsID: String, completion: @escaping DatabaseResponse)
    func insertProfilePictureIntoDatabase(SignedInUser userSettingsID: String, forImage imageData: Data, completion: @escaping DatabaseResponse)
    func performProfilePictureRequest(for urlString: String, completion: @escaping ProfilePictureResponse)
}
