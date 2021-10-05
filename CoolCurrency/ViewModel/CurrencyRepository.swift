//
//  CurrencyRepository.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/05.
//

import Foundation

struct CurrencyRepository: CurrencyRepositoryProtocol {
    
    var currency: CurrencyDataModel?
    private let currencyRequest = CurrencyRequest()
    var repositoryLoad: ((Bool) -> Void)?
    
    func requestCurrentRatesInCurrency(for baseCurrency: String, completion: @escaping (Result<CurrencyDataModel, Error>) -> Void) {
        currencyRequest.performCurrencyRequest(for: baseCurrency) { result in
            do {
                let newRateCurrency = try result.get()
                completion(.success(newRateCurrency))
                self.repositoryLoad?(true)
            } catch {
                completion(.failure(error))
            }
        }
    }
}
