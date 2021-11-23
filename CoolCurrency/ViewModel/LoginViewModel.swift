//
//  LoginViewModel.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/28.
//

import Foundation

class LoginViewModel {
    
    private weak var delegate: ViewModelDelegate?
    private var authenticationRepository: AuthenticationRepositable
    
    init(authenticationRepository: AuthenticationRepositable, delegate: ViewModelDelegate) {
        self.authenticationRepository = authenticationRepository
        self.delegate = delegate
    }
    
    func authenticateUser(_ email: String, _ password: String) {
        authenticationRepository.signInUser(email, password) { [weak self] result in
            switch result {
            case .success(_):
                self?.delegate?.bindViewModel()
            case .failure(let signInError):
                self?.delegate?.showUserErrorMessage(error: signInError)
            }
        }
    }
}
