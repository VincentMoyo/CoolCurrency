//
//  CurrencyRepositable.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/06.
//

import Foundation

typealias ListCurrencyResponseModel = (Result<CurrencyResponseModel, Error>) -> Void

protocol CurrencyRepositable {
    func performCurrencyRequest(for baseCurrency: String, completion: @escaping ListCurrencyResponseModel)
}

protocol AuthenticationRepositable {
    func registerUser(_ email: String, _ password: String, completion: @escaping (Result<Bool, Error>) -> Void)
    func signInUser(_ email: String, _ password: String, completion: @escaping (Result<Bool, Error>) -> Void)
    func signOutUser(completion: @escaping (Result<Bool, Error>) -> Void)
    func signedInUserIdentification() -> String
    var checkIfUserAlreadySignedIn: Bool { get }
}

protocol DatabaseRepositable {
    func retrieveCurrencyFromDatabase(baseCurrency: String, completion: @escaping (Result<[String: Double], Error>) -> Void)
    func retrieveUserInformationFromDatabase(userID baseUser: String, completion: @escaping (Result<[String: String], Error>) -> Void)
    func updateFirstNameUserInformationToDatabase(SignedInUser userSettingsID: String, username firstName: String)
    func updateLastNameUserInformationToDatabase(SignedInUser userSettingsID: String, userLastName lastName: String)
    func updateUserSettingsGender(SignedInUser userSettingsID: String, userGender gender: String)
    func updateUserSettingsDateOfBirth(SignedInUser userSettingsID: String, DOB: String)
    func updateDefaultCurrencyInformationToDatabase(SignedInUser userSettingsID: String, currency defaultCurrency: String)
    func updateMeasurementUnitToDatabase(SignedInUser userSettingsID: String, measurementUnit unit: String)
}
