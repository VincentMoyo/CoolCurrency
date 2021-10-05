//
//  CurrencyViewModel.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/05.
//

import Foundation

class CurrencyViewModel {
    
    private var currencyDataModel: CurrencyDataModel?
    private var currencyRepository: CurrencyRepositoryProtocol
    var modelLoad: ((Bool) -> Void)?
    var modelError: ((Error) -> Void)?
    
    init(currencyRepository: CurrencyRepositoryProtocol = CurrencyRepository()) {
        self.currencyRepository = currencyRepository
    }
    
    private func bindRepository() {
        currencyRepository.repositoryLoad = { result in
            if result {
                self.modelLoad?(true)
            }
        }
    }
    
    private func searchCurrencyRate(for baseCurrency: String) {
        currencyRepository.requestCurrentRatesInCurrency(for: baseCurrency) { result in
            do {
                let newCurrencyRate = try result.get()
                self.currencyDataModel = newCurrencyRate
            } catch {
                self.modelError?(error)
            }
        }
        bindRepository()
    }
}
