//
//  CurrencyViewModiable.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/11.
//

import Foundation

protocol CurrencyViewModiable {
    var currencyList: [String: Double] { get set }
    func fetchCurrencyList(for baseCurrency: String)
    func setCurrencyDataList(currencyData: Rates)
}
