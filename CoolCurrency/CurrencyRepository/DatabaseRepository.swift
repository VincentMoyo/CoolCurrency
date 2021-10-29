//
//  DatabaseRepository.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/20.
//

import Foundation
import FirebaseDatabase
import UIKit

class DatabaseRepository {
    
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
    
    func retrieveUserInformationFromDatabase(userID baseUser: String, completion: @escaping (Result<[UserInformation], Error>) -> Void) {
        database.child(baseUser).observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [UserInformation] else {
                return
            }
            DispatchQueue.main.async {
                
                completion(.success(value))
            }
        }
    }
    
}
