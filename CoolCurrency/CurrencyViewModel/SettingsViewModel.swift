//
//  SettingsViewModel.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/29.
//

import Foundation

class SettingsViewModel: SettingsViewModiable {
    
    private var databaseRepository: DatabaseRepositable
    private var authenticationRepository: AuthenticationRepositable
    private var userSettingsList: [String: String] = [:]
    private weak var delegate: SettingsViewModelDelegate?
    private var firstName: String?
    private var profilePictureURLString: String?
    var profilePictureDataImage: Data?
    private var lastName: String?
    private var gender: Int?
    private var birthDate: Date?
    private var defaultCurrency: String?
    private var unitMeasurement: Int?
    var selectedRow = 0
    let currencyList = ["GBP", "ZAR", "USD", "INR", "CAD", "GHS", "JPY", "RUB", "CNY", "EUR", "AED", "BRL", "AUD"]
    
    init(databaseRepository: DatabaseRepositable, authenticationRepository: AuthenticationRepositable, delegate: SettingsViewModelDelegate) {
        self.databaseRepository = databaseRepository
        self.authenticationRepository = authenticationRepository
        self.delegate = delegate
    }
    
    func loadUserSettingsFromDatabase() {
        databaseRepository.retrieveUserInformationFromDatabase(userID: authenticationRepository.signedInUserIdentification(), completion: { [weak self] result in
            do {
                let newUserDetails = try result.get()
                self?.userSettingsList = newUserDetails
                self?.checkUserList()
                self?.downloadProfileImageFromDatabase()
                 self?.delegate?.bindViewModel()
            } catch {
                self?.delegate?.showUserErrorMessage(error: error)
            }
        })
    }
    
    var retrieveFirstName: String {
        firstName ?? "Not Set"
    }
    
    var retrieveProfilePictureURLString: String {
        profilePictureURLString ?? ""
    }
    
    var retrieveLastName: String {
        lastName ?? "Not Set"
    }
    
    var retrieveGender: Int {
        gender ?? 0
    }
    
    var retrieveBirthDate: Date {
        birthDate ?? Date.now
    }
    
    var retrieveDefaultCurrency: String {
        defaultCurrency ?? "Not Set"
    }
    
    var retrieveUnitMeasurement: Int {
        unitMeasurement ?? 0
    }
    
    func downloadProfileImageFromDatabase() {
        guard let urlString = profilePictureURLString else { return }
        databaseRepository.performProfilePictureRequest(for: urlString, completion: { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.profilePictureDataImage = imageData
                self?.delegate?.bindViewModel()
            case .failure(let updateToDataError):
                self?.delegate?.showUserErrorMessage(error: updateToDataError)
            }
        })
    }
    
    func updateProfilePicture(_ imagePNG: Data) {
        databaseRepository.insertProfilePictureIntoDatabase(SignedInUser: authenticationRepository.signedInUserIdentification(),
                                                            forImage: imagePNG,
                                                            completion: { [weak self] result in
            switch result {
            case .success(_):
                self?.loadUserSettingsFromDatabase()
            case .failure(let updateToDataError):
                self?.delegate?.showUserErrorMessage(error: updateToDataError)
            }
        })
    }
    
    func updateFirstName(_ firstName: String) {
        databaseRepository.updateFirstNameUserInformationToDatabase(SignedInUser: authenticationRepository.signedInUserIdentification(),
                                                                    username: firstName, completion: { [weak self] result in
            switch result {
            case .success(_):
                self?.loadUserSettingsFromDatabase()
            case .failure(let updateToDataError):
                self?.delegate?.showUserErrorMessage(error: updateToDataError)
            }
        })
    }
    
    func updateLastName(_ lastName: String) {
        databaseRepository.updateLastNameUserInformationToDatabase(SignedInUser: authenticationRepository.signedInUserIdentification(),
                                                                   userLastName: lastName, completion: { [weak self] result in
            switch result {
            case .success(_):
                self?.loadUserSettingsFromDatabase()
            case .failure(let updateToDataError):
                self?.delegate?.showUserErrorMessage(error: updateToDataError)
            }
        })
    }
    
    func updateGender(_ gender: String) {
        databaseRepository.updateUserSettingsGender(SignedInUser: authenticationRepository.signedInUserIdentification(),
                                                    userGender: gender, completion: { [weak self] result in
            switch result {
            case .success(_):
                self?.loadUserSettingsFromDatabase()
            case .failure(let updateToDataError):
                self?.delegate?.showUserErrorMessage(error: updateToDataError)
            }
        })
    }
    
    func updateDateOfBirth(_ dateOfBirth: String) {
        databaseRepository.updateUserSettingsDateOfBirth(SignedInUser: authenticationRepository.signedInUserIdentification(),
                                                         DOB: dateOfBirth, completion: { [weak self] result in
            switch result {
            case .success(_):
                self?.loadUserSettingsFromDatabase()
            case .failure(let updateToDataError):
                self?.delegate?.showUserErrorMessage(error: updateToDataError)
            }
        })
    }
    
    func updateDefaultCurrency(_ defaultCurrency: String) {
        databaseRepository.updateDefaultCurrencyInformationToDatabase(SignedInUser: authenticationRepository.signedInUserIdentification(),
                                                                      currency: defaultCurrency, completion: { [weak self] result in
            switch result {
            case .success(_):
                self?.loadUserSettingsFromDatabase()
            case .failure(let updateToDataError):
                self?.delegate?.showUserErrorMessage(error: updateToDataError)
            }
        })
    }
    
    func updateMeasurementUnit(_ unit: String) {
        databaseRepository.updateMeasurementUnitToDatabase(SignedInUser: authenticationRepository.signedInUserIdentification(),
                                                           measurementUnit: unit, completion: { [weak self] result in
            switch result {
            case .success(_):
                self?.loadUserSettingsFromDatabase()
            case .failure(let updateToDataError):
                self?.delegate?.showUserErrorMessage(error: updateToDataError)
            }
        })
    }
    
    private func checkUserList() {
        for (key, value) in userSettingsList {
            switch key {
            case "FirstName":
                firstName = value
            case "LastName":
                lastName = value
            case "Gender":
                gender = value == "Female" ? 0 : 1
            case "Date of Birth":
                Constants.FormatForDate.dateFormatterGet.dateFormat = Constants.FormatForDate.DateFormate
                guard let dateResult = Constants.FormatForDate.dateFormatterGet.date(from: value) else { return }
                birthDate = dateResult
            case "DefaultCurrency":
                defaultCurrency = value
            case "MeasurementUnit":
                unitMeasurement = value == "Grams" ? 0 : 1
            case "ProfileImage":
                profilePictureURLString = value
            default:
                break
            }
        }
    }
    
    func resetEmail(newEmail email: String) {
        authenticationRepository.resetEmailToDatabase(newEmail: email) { [weak self] result in
            switch result {
            case .success(_):
                self?.loadUserSettingsFromDatabase()
            case .failure(let signInError):
                self?.delegate?.showUserErrorMessage(error: signInError)
            }
        }
    }
    
    func signOutCurrentUser() {
        authenticationRepository.signOutUser { [weak self] result in
            switch result {
            case .success(_):
                self?.delegate?.signOutBindViewModel()
            case .failure(let signInError):
                self?.delegate?.showUserErrorMessage(error: signInError)
            }
        }
    }
}
