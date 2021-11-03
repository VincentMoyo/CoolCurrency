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
    private let authenticationRepo = AuthenticationRepository(authenticationReference: Auth.auth())
    var userSettingsList: [String: String] = [:]
    private weak var delegate: SettingsViewModelDelegate?
    var firstName = ""
    var lastName = ""
    var gender = 0
    var birthDate: Date
    
    init(delegate: SettingsViewModelDelegate) {
        self.delegate = delegate
        self.birthDate = Date.init()
    }
    
    func loadUserSettingsFromDatabase() {
        database.retrieveUserInformationFromDatabase(userID: authenticationRepo.signedInUserIdentification()) { [weak self] result in
            do {
                let newUserDetails = try result.get()
                self?.userSettingsList = newUserDetails
                self?.delegate?.bindViewModel()
            } catch {
                self?.delegate?.showUserErrorMessage(error: error)
            }
        }
    }
    
    func updateFirstName(_ firstName: String) {
        database.updateFirstNameUserInformationToDatabase(SignedInUser: authenticationRepo.signedInUserIdentification(), username: firstName)
    }
    
    func updateLastName(_ lastName: String) {
        database.updateLastNameUserInformationToDatabase(SignedInUser: authenticationRepo.signedInUserIdentification(), userLastName: lastName)
    }
    
    func updateGender(_ gender: String) {
        database.updateUserSettingsGender(SignedInUser: authenticationRepo.signedInUserIdentification(), userGender: gender)
    }
    
    func updateDateOfBirth(_ dateOfBirth: String) {
        database.updateUserSettingsDateOfBirth(SignedInUser: authenticationRepo.signedInUserIdentification(), DOB: dateOfBirth)
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
    
    func signOutCurrentUser() {
        authenticationRepo.signOutUser { [weak self] result in
            switch result {
            case .success(_):
                self?.delegate?.signOutBindViewModel()
            case .failure(let signInError):
                self?.delegate?.showUserErrorMessage(error: signInError)
            }
        }
    }
}
