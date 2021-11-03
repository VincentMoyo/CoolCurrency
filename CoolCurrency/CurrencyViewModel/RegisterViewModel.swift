//
//  RegisterViewModel.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/28.
//

import Foundation
import FirebaseAuth

class RegisterViewModel {
    
    private weak var delegate: ViewModelDelegate?
    private let authentication = AuthenticationRepository(authenticationReference: Auth.auth())
    
    init(delegate: ViewModelDelegate) {
        self.delegate = delegate
    }
    
    func registerUser(_ email: String, _ password: String) {
        authentication.registerUser(email, password) { [weak self] result in
            switch result {
            case .success(_):
                self?.delegate?.bindViewModel()
            case .failure(let signInError):
                self?.delegate?.showUserErrorMessage(error: signInError)
            }
        }
    }
}
