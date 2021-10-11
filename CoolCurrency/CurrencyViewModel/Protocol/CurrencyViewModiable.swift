//
//  CurrencyViewModiable.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/11.
//

import Foundation

protocol CurrencyViewModiable {
    func fetchCurrencyList(for baseCurrency: String)
    func setCurrencyDataList(currencyData: Rates)
}
