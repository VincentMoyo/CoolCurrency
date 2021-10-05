//
//  Protocols.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/05.
//

import Foundation

protocol ErrorReporting: AnyObject {
    func showUserErrorMessageDidInitiate(_ message: String)
}

protocol CurrencyRepositoryProtocol {
    var currency: CurrencyDataModel? { get set }
    var repositoryLoad: ((Bool) -> Void)? { get set }
    func requestCurrentRatesInCurrency(for baseCurrency: String, completion: @escaping (Result<CurrencyDataModel, Error>) -> Void)
}
