//
//  CurrencyViewModiable.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/08.
//

import Foundation

protocol CurrencyViewModiable {
    func fetchCurrencyList(for baseCurrency: String)
    func setCurrencyDataList(currencyData: Rates)
    func roundOffCurrency(for currency: Double) -> Double
    var modelLoad: ((Bool) -> Void)? { get set }
}
