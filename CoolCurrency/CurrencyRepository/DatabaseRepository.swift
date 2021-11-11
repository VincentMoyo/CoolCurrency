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
    
    private var databaseReference: DatabaseReference
    
    init(databaseReference: DatabaseReference) {
        self.databaseReference = databaseReference
    }
    
    func insertCurrencyIntoDatabase(for baseCurrency: String, with currencyList: [String: Double], completion: @escaping DatabaseResponse) {
        databaseReference.child(baseCurrency).setValue(currencyList)
    }
    
    func retrieveCurrencyFromDatabase(baseCurrency: String, completion: @escaping CurrencyFromDatabaseResponse) {
        databaseReference.child(baseCurrency).observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: Double] else {
                return
            }
            DispatchQueue.main.async {
                completion(.success(value))
            }
        }
    }
    
    func updateFirstNameUserInformationToDatabase(SignedInUser userSettingsID: String, username firstName: String, completion: @escaping DatabaseResponse) {
        databaseReference.child("Users/\(userSettingsID)/FirstName").setValue(firstName) { (error: Error?, _: DatabaseReference) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func updateLastNameUserInformationToDatabase(SignedInUser userSettingsID: String, userLastName lastName: String, completion: @escaping DatabaseResponse) {
        databaseReference.child("Users/\(userSettingsID)/LastName").setValue(lastName) { (error: Error?, _: DatabaseReference) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func updateUserSettingsGender(SignedInUser userSettingsID: String, userGender gender: String, completion: @escaping DatabaseResponse) {
        databaseReference.child("Users/\(userSettingsID)/Gender").setValue(gender) { (error: Error?, _: DatabaseReference) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func updateUserSettingsDateOfBirth(SignedInUser userSettingsID: String, DOB: String, completion: @escaping DatabaseResponse) {
        databaseReference.child("Users/\(userSettingsID)/Date of Birth").setValue(DOB) { (error: Error?, _: DatabaseReference) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func updateDefaultCurrencyInformationToDatabase(SignedInUser userSettingsID: String, currency defaultCurrency: String, completion: @escaping DatabaseResponse) {
        databaseReference.child("Users/\(userSettingsID)/DefaultCurrency").setValue(defaultCurrency) { (error: Error?, _: DatabaseReference) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func updateMeasurementUnitToDatabase(SignedInUser userSettingsID: String, measurementUnit unit: String, completion: @escaping DatabaseResponse) {
        databaseReference.child("Users/\(userSettingsID)/MeasurementUnit").setValue(unit) { (error: Error?, _: DatabaseReference) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func createNewUserSettings(SignedInUser userSettingsID: String, completion: @escaping DatabaseResponse) {
        let newUserInformation: [String: Any] = [
            "FirstName": "Not Set",
            "LastName": "Not Set",
            "Gender": "Not Set",
            "Date of Birth": "Not Set",
            "DefaultCurrency": "Not Set",
            "MeasurementUnit": "Not Set"
        ]
        
        databaseReference.child("Users").child(userSettingsID).setValue(newUserInformation) { (error: Error?, _:DatabaseReference) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func retrieveUserInformationFromDatabase(userID baseUser: String, completion: @escaping UserInformationFromDatabaseResponse) {
        databaseReference.child("Users").child(baseUser).observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: String] else {
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(value))
            }
        }
    }
}
