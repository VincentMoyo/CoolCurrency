//
//  WelcomeViewModel.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/28.
//

import Foundation
import FirebaseAuth

struct WelcomeViewModel {
    
    private let authenticationRepo = AuthenticationRepository(authenticationReference: Auth.auth())
    
    var isUserSignedIn: Bool {
       return authenticationRepo.checkIfUserAlreadySignedIn
    }
}
