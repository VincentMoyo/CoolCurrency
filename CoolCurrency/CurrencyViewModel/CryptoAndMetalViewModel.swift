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
    let currencyList = ["GBP", "ZAR", "USD", "INR", "CAD", "GHS", "JPY", "RUB", "CNY", "EUR", "AED", "BRL", "AUD"]
    
    init(repositoryCryptoAndMetals: CryptoAndMetalsRepositable, delegate: CryptoAndMetalViewModelDelegate) {
        self.cryptoAndMetalsRepository = repositoryCryptoAndMetals
        self.delegate = delegate
    }
    
    func retrieveRoundedOffPriceOfGold() -> Double? {
        metalsResponse?.gold.roundOff()
    }
    
    func retrieveRoundedOffPriceOfSilver() -> Double? {
        metalsResponse?.silver.roundOff()
    }
    
    func retrieveRoundedOffPriceOfPlatinum() -> Double? {
        metalsResponse?.platinum.roundOff()
    }
    
    func retrieveRoundedOffPriceOfBitcoin() -> Double {
        price.rate.roundOff()
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
                self?.delegate?.bindViewModel(self!)
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
                self?.delegate?.bindViewModel(self!)
            case .failure(let error):
                self?.delegate?.showUserErrorMessage(error: error)
            }
        })
    }
}
