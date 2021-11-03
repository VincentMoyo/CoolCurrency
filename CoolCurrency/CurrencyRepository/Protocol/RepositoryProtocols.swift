//
//  CurrencyRepositable.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/06.
//

import Foundation

typealias ListCurrencyResponseModel = (Result<CurrencyResponseModel, Error>) -> Void
typealias BitcoinDataResponseModel = (Result<CoinData, Error>) -> Void
typealias MetalsDataResponseModel = (Result<MetalsResponseModel, Error>) -> Void

protocol CurrencyRepositable {
    func performCurrencyRequest(for baseCurrency: String, completion: @escaping ListCurrencyResponseModel)
}

protocol CryptoAndMetalsRepositable {
    func performBitcoinValueRequest(for baseCurrency: String, completion: @escaping BitcoinDataResponseModel)
    func performMetalsValueRequest(for baseCurrency: String, completion: @escaping MetalsDataResponseModel)
}

protocol AuthenticationRepositable {
    func signInUser(_ email: String, _ password: String, completion: @escaping (Result<Bool, Error>) -> Void)
    func registerUser(_ email: String, _ password: String, completion: @escaping (Result<Bool, Error>) -> Void)
    func signedInUserIdentification() -> String
}
