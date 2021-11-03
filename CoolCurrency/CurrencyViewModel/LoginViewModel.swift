//
//  LoginViewModel.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/28.
//

import Foundation
import FirebaseAuth

class LoginViewModel {
    
    private weak var delegate: ViewModelDelegate?
    private let authenticationRepo = AuthenticationRepository(authenticationReference: Auth.auth())
    
    init(delegate: ViewModelDelegate) {
        self.delegate = delegate
    }
    
    func authenticateUser(_ email: String, _ password: String) {
        authenticationRepo.signInUser(email, password) { [weak self] result in
            switch result {
            case .success(_):
                self?.delegate?.bindViewModel()
            case .failure(let signInError):
                self?.delegate?.showUserErrorMessage(error: signInError)
            }
        }
    }
}
