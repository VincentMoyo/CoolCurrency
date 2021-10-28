//
//  CryptoAndMetalViewModel.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/21.
//

import Foundation

class CryptoAndMetalViewModel: CryptoAndMetalViewModiable {
    
    private var price: CoinData = CoinData(rate: 0.0)
    private var metalsResponse: MetalRates?
    private weak var delegate: CryptoAndMetalViewModelDelegate?
    private var cryptoAndMetalsRepository: CryptoAndMetalsRepositable
    var selectedCurrency = ""
    let currencyList = ["GBP", "ZAR", "USD", "INR", "CAD", "GHS", "JPY", "RUB", "CNY", "EUR", "AED", "BRL", "AUD"]
    
    init(repositoryCryptoAndMetals: CryptoAndMetalsRepositable, delegate: CryptoAndMetalViewModelDelegate) {
        self.cryptoAndMetalsRepository = repositoryCryptoAndMetals
        self.delegate = delegate
    }
    
    var retrieveRoundedOffPriceOfGold: String {
        String(metalsResponse?.gold.convertOunceToGramsAndRoundOff() ?? 0.0)
    }
    
    var retrieveRoundedOffPriceOfSilver: String {
        String(metalsResponse?.silver.convertOunceToGramsAndRoundOff() ?? 0.0)
    }
    
    var retrieveRoundedOffPriceOfPlatinum: String {
        String(metalsResponse?.platinum.convertOunceToGramsAndRoundOff() ?? 0.0)
    }
    
    var retrieveRoundedOffPriceOfBitcoin: String {
        String(price.rate.roundOff())
    }
    
    func fetchBitcoinAndMetalPrices(for baseCurrency: String) {
        fetchBitcoinPrice(for: baseCurrency)
        fetchPriceOfMetals(for: baseCurrency)
    }
    
    private func fetchBitcoinPrice(for baseCurrency: String) {
        cryptoAndMetalsRepository.performBitcoinValueRequest(for: baseCurrency,
                                                     completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.price = response
                self?.delegate?.bindViewModel()
            case .failure(let error):
                self?.delegate?.showUserErrorMessage(error: error)
            }
        })
    }
    
    private func fetchPriceOfMetals(for baseCurrency: String) {
        cryptoAndMetalsRepository.performMetalsValueRequest(for: baseCurrency,
                                                     completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.metalsResponse = response.rates
                self?.delegate?.bindViewModel()
            case .failure(let error):
                self?.delegate?.showUserErrorMessage(error: error)
            }
        })
    }
}
