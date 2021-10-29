//
//  UserInformation.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/29.
//

import Foundation

struct UserInformation {
    
    let firstName: String
    let lastName: String
    let gender: String
    let dateOfBirth: String
    let sender: String
    
    internal init(firstName: String, lastName: String, gender: String, dateOfBirth: String, sender: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.dateOfBirth = dateOfBirth
        self.sender = sender
    }
}
