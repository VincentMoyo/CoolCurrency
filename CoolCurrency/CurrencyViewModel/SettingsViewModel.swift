//
//  SettingsViewModel.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/29.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class SettingsViewModel {
    
    let database = DatabaseRepository(databaseReference: Database.database().reference())
    var userSettingsList: [String: String] = [:]
    private weak var delegate: ViewModelDelegate?
    var firstName = ""
    var lastName = ""
    var gender = 0
    var birthDate: Date
    
    init(delegate: ViewModelDelegate) {
        self.delegate = delegate
        self.birthDate = Date.init()
    }
    
    func loadUserSettingsFromDatabase() {
        database.retrieveUserInformationFromDatabase(userID: Auth.auth().currentUser!.uid) { result in
            do {
                let newUserDetails = try result.get()
                self.userSettingsList = newUserDetails
                self.delegate?.bindViewModel()
            } catch {
                self.delegate?.showUserErrorMessage(error: error)
            }
        }
    }
    
    func updateFirstName(_ firstName: String) {
        database.updateFirstNameUserInformationToDatabase(SignedInUser: Auth.auth().currentUser!.uid, username: firstName)
    }
    
    func updateLastName(_ lastName: String) {
        database.updateLastNameUserInformationToDatabase(SignedInUser: Auth.auth().currentUser!.uid, userLastName: lastName)
    }
    
    func updateGender(_ gender: String) {
        database.updateUserSettingsGender(SignedInUser: Auth.auth().currentUser!.uid, userGender: gender)
    }
    
    func updateDateOfBirth(_ dateOfBirth: String) {
        database.updateUserSettingsDateOfBirth(SignedInUser: Auth.auth().currentUser!.uid, DOB: dateOfBirth)
    }
    
    func checkUserList() {
        self.userSettingsList.forEach { settings in
            if settings.key == "FirstName" {
                firstName = settings.value
            } else if settings.key == "LastName" {
                lastName = settings.value
            } else if settings.key == "Gender" {
                if settings.value == "Female" {
                    gender = 0
                } else {
                    gender = 1
                }
            } else if settings.key == "Date of Birth" {
                Constants.FormatForDate.dateFormatterGet.dateFormat = Constants.FormatForDate.DateFormate
                let dateResult = Constants.FormatForDate.dateFormatterGet.date(from: settings.value)
                birthDate = dateResult!
            }
        }
    }
    
    func signOutUser() {
        let firebaseAuth = Auth.auth()
        do {
           try firebaseAuth.signOut()
            self.delegate?.bindViewModel()
        } catch let signOutError as NSError {
            self.delegate?.showUserErrorMessage(error: signOutError)
        }
    }
}
