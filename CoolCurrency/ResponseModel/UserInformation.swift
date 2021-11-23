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

    internal init(firstName: String, lastName: String, gender: String, dateOfBirth: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.dateOfBirth = dateOfBirth
    }
}
