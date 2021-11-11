//
//  RegisterViewModel.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/28.
//

import Foundation

class RegisterViewModel {
    
    private weak var delegate: ViewModelDelegate?
    private var authenticationRepository: AuthenticationRepositable
    private var databaseRepository: DatabaseRepositable
    
    init(authenticationRepository: AuthenticationRepositable, delegate: ViewModelDelegate, database: DatabaseRepositable) {
        self.authenticationRepository = authenticationRepository
        self.delegate = delegate
        self.databaseRepository = database
    }
    
    func registerUser(_ email: String, _ password: String) {
        authenticationRepository.registerUser(email, password) { [weak self] result in
            switch result {
            case .success(_):
                guard let checkUserID = self?.authenticationRepository.signedInUserIdentification()
                else {
                    return
                    
                }
                self?.databaseRepository.createNewUserSettings(SignedInUser: checkUserID)
                self?.delegate?.bindViewModel()
            case .failure(let signInError):
                self?.delegate?.showUserErrorMessage(error: signInError)
            }
        }
    }
}
