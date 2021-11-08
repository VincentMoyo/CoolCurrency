//
//  CurrencyViewModiable.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/11.
//

import Foundation

protocol CurrencyViewModiable {
    func fetchCurrencyListFromAPI(for baseCurrency: String)
}

protocol CryptoAndMetalViewModiable {
    func fetchBitcoinAndMetalPrices(for baseCurrency: String)
}

protocol SettingsViewModiable {
    func loadUserSettingsFromDatabase()
}
