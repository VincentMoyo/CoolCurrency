//
//  DatabaseRepository.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/20.
//

import Foundation
import FirebaseDatabase
import UIKit

class DatabaseRepository: DatabaseRepositable {
    
    private var database: DatabaseReference
    
    init(databaseReference: DatabaseReference) {
        self.database = databaseReference
    }

    func insertCurrencyIntoDatabase(for baseCurrency: String, with currencyList: [String: Double]) {
        database.child(baseCurrency).setValue(currencyList)
    }
    
    func retrieveCurrencyFromDatabase(baseCurrency: String, completion: @escaping (Result<[String: Double], Error>) -> Void) {
        database.child(baseCurrency).observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: Double] else {
                return
            }
            DispatchQueue.main.async {
                completion(.success(value))
            }
        }
    }
    
    func updateFirstNameUserInformationToDatabase(SignedInUser userSettingsID: String, username firstName: String) {
        database.child("Users/\(userSettingsID)/FirstName").setValue(firstName)
    }
    
    func updateLastNameUserInformationToDatabase(SignedInUser userSettingsID: String, userLastName lastName: String) {
        database.child("Users/\(userSettingsID)/LastName").setValue(lastName)
    }
    
    func updateUserSettingsGender(SignedInUser userSettingsID: String, userGender gender: String) {
        database.child("Users/\(userSettingsID)/Gender").setValue(gender)
    }
    
    func updateUserSettingsDateOfBirth(SignedInUser userSettingsID: String, DOB: String) {
        database.child("Users/\(userSettingsID)/Date of Birth").setValue(DOB)
    }
    
    func retrieveUserInformationFromDatabase(userID baseUser: String, completion: @escaping (Result<[String: String], Error>) -> Void) {
        database.child("Users").child(baseUser).observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: String] else {
                return
            }
            DispatchQueue.main.async {
                completion(.success(value))
            }
        }
    }
}
