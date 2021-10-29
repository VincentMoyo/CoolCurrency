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
    var userSettingsList: [UserInformation] = []
    private weak var delegate: ViewModelDelegate?
    
    init(delegate: ViewModelDelegate) {
        self.delegate = delegate
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
