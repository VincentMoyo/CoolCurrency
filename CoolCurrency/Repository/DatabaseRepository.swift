//
//  DatabaseRepository.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/20.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import UIKit

class DatabaseRepository: DatabaseRepositable {
    
    private var databaseReference: DatabaseReference
    private let storageReference: StorageReference
    let dispatchGroup = DispatchGroup()
    
    init(databaseReference: DatabaseReference, storageReference: StorageReference) {
        self.databaseReference = databaseReference
        self.storageReference = storageReference
    }
    
    func insertCurrencyIntoDatabase(for baseCurrency: String, with currencyList: [String: Double], completion: @escaping DatabaseResponse) {
        databaseReference.child(baseCurrency).setValue(currencyList)
    }
    
    func insertProfilePictureIntoDatabase(SignedInUser userSettingsID: String, forImage imageData: Data, completion: @escaping DatabaseResponse) {
        storageReference.child("ProfilePictures/\(userSettingsID).png").putData(imageData,
                                                                                metadata: nil,
                                                                                completion: { _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                self.storageReference.child("ProfilePictures/\(userSettingsID).png").downloadURL(completion: {url, error in
                    guard let url = url, error == nil else {
                        return
                    }
                    let urlString = url.absoluteString
                    self.updateProfilePictureToDatabase(SignedInUser: userSettingsID, userURLString: urlString, completion: { result in
                        switch result {
                        case .success(_):
                            completion(.success(true))
                        case .failure(let updateToDataError):
                            completion(.failure(updateToDataError))
                        }
                    })
                })
            }
        })
    }
    
    func updateUsersScoreboard(SignedInUser userNumber: Int, name userName: String, finalScore userFinalScore: String, totalScore userTotalScore: String, completion: @escaping DatabaseResponse) {
        let userObject: [String: Any] = [
            "Name": userName as NSObject,
            "FinalScore": userFinalScore,
            "TotalScore": userTotalScore
        ]
        
        self.databaseReference.child("Scoreboard/UserNumber\(userNumber)").setValue(userObject) { (error: Error?, _: DatabaseReference) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func retrieveUserScoreboards(completion: @escaping(Result<[LeadershipBoardDataModel], Error>) -> Void) {
        var leaderBoardsList: [LeadershipBoardDataModel] = []
        let completionLeaderBoardItem = DispatchWorkItem { completion(.success(leaderBoardsList)) }
        databaseReference.child("Scoreboard").observeSingleEvent(of: .value, with: { (snapshot) in
            let numberOfUsers = snapshot.childrenCount
            for userNumber in 0..<numberOfUsers {
                self.dispatchGroup.enter()
                self.databaseReference.child("Scoreboard/UserNumber\(userNumber)").observeSingleEvent(of: .value) { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    let username = value?["Name"] as? String ?? ""
                    let correctAnswers = value?["FinalScore"] as? String ?? ""
                    let totalScores = value?["TotalScore"] as? String ?? ""
                    let tempLeadershipBoard = LeadershipBoardDataModel(userNumber: Int(userNumber),
                                                                       name: username,
                                                                       correctAnswers: Int(correctAnswers) ?? 0,
                                                                       totalScore: Int(totalScores) ?? 0)
                    leaderBoardsList.append(tempLeadershipBoard)
                    self.dispatchGroup.leave()
                }
            }
            self.dispatchGroup.notify(queue: DispatchQueue.main, work: completionLeaderBoardItem)
        }) {(error) in
            completion(.failure(error))
        }
    }
    
    func updateProfilePictureToDatabase(SignedInUser userSettingsID: String, userURLString urlString: String, completion: @escaping DatabaseResponse) {
        databaseReference.child("Users/\(userSettingsID)/ProfileImage").setValue(urlString) { (error: Error?, _: DatabaseReference) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
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
    
    func performProfilePictureRequest(for urlString: String, completion: @escaping ProfilePictureResponse) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            }
        })
        task.resume()
    }
}
