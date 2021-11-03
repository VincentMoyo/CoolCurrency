//
//  AuthenticationRepository.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/11/02.
//

import Foundation
import FirebaseAuth

struct AuthenticationRepository: AuthenticationRepositable {
    
    private var authentication: Auth
    
    init(authenticationReference: Auth) {
        self.authentication = authenticationReference
    }
    
    var checkIfUserAlreadySignedIn: Bool {
        authentication.currentUser != nil
    }
    
    func registerUser(_ email: String, _ password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        authentication.createUser(withEmail: email, password: password) { _, error in
            if let err = error {
                completion(.failure(err))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func signOutUser(completion: @escaping (Result<Bool, Error>) -> Void) {
        do {
            try authentication.signOut()
            completion(.success(true))
        } catch let signOutError as NSError {
            completion(.failure(signOutError))
        }
    }
    
    func signInUser(_ email: String, _ password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        authentication.signIn(withEmail: email, password: password) { _, error in
            if let err = error {
                completion(.failure(err))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func signedInUserIdentification() -> String {
        guard let signedInUser = authentication.currentUser?.uid else {
            return ""
        }
        return signedInUser
    }
}
