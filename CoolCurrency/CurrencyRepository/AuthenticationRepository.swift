//
//  AuthenticationRepository.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/11/02.
//

import Foundation
import FirebaseAuth

struct AuthenticationRepository: AuthenticationRepositable {
    
    func checkIfUserAlreadySignedIn() -> Bool {
        if Auth.auth().currentUser != nil {
            return true
        } else {
            return false
        }
    }
    
    func registerUser(_ email: String, _ password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if let err = error {
                completion(.failure(err))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func signInUser(_ email: String, _ password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let err = error {
                completion(.failure(err))
            } else {
                completion(.success(true))
            }
        }
    }
    
}
