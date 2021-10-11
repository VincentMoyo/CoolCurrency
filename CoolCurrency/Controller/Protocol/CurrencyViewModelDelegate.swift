//
//  CurrencyViewModelDelegate.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/06.
//

import Foundation

protocol CurrencyViewModelDelegate: AnyObject {
    func showUserErrorMessage(error: Error)
    func bindViewModel(_ currencyViewModel: CurrencyViewModel)
}
