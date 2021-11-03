//
//  WelcomeViewModel.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/28.
//

import Foundation

struct WelcomeViewModel {
    
    private var authentication: AuthenticationRepositable
    
    init(authenticationRepository: AuthenticationRepositable) {
        self.authentication = authenticationRepository
    }
    
    var isUserSignedIn: Bool {
       return authentication.checkIfUserAlreadySignedIn
    }
}
