//
//  RegisterViewModel.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/28.
//

import Foundation
import FirebaseAuth

struct RegisterViewModel {
    
    private weak var delegate: ViewModelDelegate?
    
    init(delegate: ViewModelDelegate) {
        self.delegate = delegate
    }
    
    func registerUser(_ email: String, _ password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if let err = error {
                self.delegate?.showUserErrorMessage(error: err)
            } else {
                self.delegate?.bindViewModel()
            }
        }
    }
}
