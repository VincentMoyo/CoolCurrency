//
//  CurrencyRepositable.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/06.
//

import Foundation

typealias ListCurrencyResponseModel = (Result<CurrencyResponseModel, Error>) -> Void

protocol CurrencyRepositable {
    func performCurrencyRequest(for baseCurrency: String, completion: @escaping ListCurrencyResponseModel)
}

protocol CurrencyRepositoryProtocol {
    var currency: CurrencyDataModel? { get set }
    var repositoryLoad: ((Bool) -> Void)? { get set }
    func requestCurrentRatesInCurrency(for baseCurrency: String, completion: @escaping (Result<CurrencyDataModel, Error>) -> Void)
}
