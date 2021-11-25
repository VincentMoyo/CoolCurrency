//
//  CurrencyViewModelDelegate.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/06.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func showUserErrorMessage(error: Error)
    func bindViewModel()
}

protocol AuthenticationViewModelDelegate: AnyObject {
    func showUserErrorMessage(error: Error)
    func bindViewModel()
    func stopActivityLoader()
}

protocol SettingsViewModelDelegate: AnyObject {
    func showUserErrorMessage(error: Error)
    func bindViewModel()
    func signOutBindViewModel()
}
