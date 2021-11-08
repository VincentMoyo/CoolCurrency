//
//  WelcomeViewModel.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/28.
//

import Foundation

struct WelcomeViewModel {
    
    private var authenticationRepository: AuthenticationRepositable
    
    init(authenticationRepository: AuthenticationRepositable) {
        self.authenticationRepository = authenticationRepository
    }
    
    var isUserSignedIn: Bool {
       return authenticationRepository.checkIfUserAlreadySignedIn
    }
}
