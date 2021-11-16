//
//  NavigationViewModel.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/11/15.
//

import Foundation

class NavigationViewModel {
    
    private weak var delegate: ViewModelDelegate?
    private var databaseRepository: DatabaseRepositable
    private var authenticationRepository: AuthenticationRepositable
    private var userSettingsList: [String: String] = [:]
    private var profilePictureURLString: String?
    var profilePictureDataImage: Data?
    
    init(delegate: ViewModelDelegate, database: DatabaseRepositable, authenticationRepository: AuthenticationRepositable) {
        self.delegate = delegate
        self.databaseRepository = database
        self.authenticationRepository = authenticationRepository
    }
    
    var retrieveProfilePictureURLString: String {
        profilePictureURLString ?? ""
    }
    
    func loadUserSettingsFromDatabase() {
        databaseRepository.retrieveUserInformationFromDatabase(userID: authenticationRepository.signedInUserIdentification(), completion: { [weak self] result in
            do {
                let newUserDetails = try result.get()
                self?.userSettingsList = newUserDetails
                self?.checkUserList()
                self?.downloadProfileImageFromDatabase()
                // self?.delegate?.bindViewModel()
            } catch {
                self?.delegate?.showUserErrorMessage(error: error)
            }
        })
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
    
    private func checkUserList() {
        for (key, value) in userSettingsList {
            switch key {
            case "ProfileImage":
                profilePictureURLString = value
            default:
                break
            }
        }
    }
    
}
