//
//  CurrencyRepository.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/05.
//

import Foundation

struct CurrencyRepository {
    
    private let currencyRequest = CurrencyRequest()
    var repositoryLoad: ((Bool) -> Void)?
    
    func performCurrencyRequest(for baseCurrency: String, completion: @escaping (Result<CurrencyResponseModel, Error>) -> Void) {
        currencyRequest.performCurrencyRequest(for: baseCurrency) { result in
            do {
                let newCurrency = try result.get()
                repositoryLoad?(true)
                completion(.success(newCurrency))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
