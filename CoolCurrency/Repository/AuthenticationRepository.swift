//
//  AuthenticationRepository.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/11/02.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

struct AuthenticationRepository: AuthenticationRepositable {
    
    private var authentication: Auth
    
    init(authenticationReference: Auth) {
        self.authentication = authenticationReference
    }
    
    var checkIfUserAlreadySignedIn: Bool {
        authentication.currentUser != nil
    }
    
    func resetEmailToDatabase(newEmail email: String, completion: @escaping DatabaseResponse) {
        authentication.currentUser?.updateEmail(to: email) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func registerUser(_ email: String, _ password: String, completion: @escaping DatabaseResponse) {
        authentication.createUser(withEmail: email, password: password) { _, error in
            if let err = error {
                completion(.failure(err))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func signOutUser(completion: @escaping DatabaseResponse) {
        do {
            try authentication.signOut()
            completion(.success(true))
        } catch let signOutError as NSError {
            completion(.failure(signOutError))
        }
    }
    
    func signInUser(_ email: String, _ password: String, completion: @escaping DatabaseResponse) {
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
