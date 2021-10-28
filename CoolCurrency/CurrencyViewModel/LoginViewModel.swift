//
//  LoginViewModel.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/28.
//

import Foundation
import FirebaseAuth

struct LoginViewModel {
    
    private weak var delegate: ViewModelDelegate?
    
    init(delegate: ViewModelDelegate) {
        self.delegate = delegate
    }
    
    func authenticateUser(_ email: String, _ password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let err = error {
                self.delegate?.showUserErrorMessage(error: err)
            } else {
                self.delegate?.bindViewModel()
            }
        }
    }
    
}
