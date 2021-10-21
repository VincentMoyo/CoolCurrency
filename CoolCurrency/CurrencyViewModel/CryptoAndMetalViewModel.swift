//
//  CryptoAndMetalViewModel.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/21.
//

import Foundation

class CryptoAndMetalViewModel: CryptoAndMetalViewModiable {
    
    let currencyArray = ["GBP", "ZAR", "USD", "INR", "CAD", "GHS", "JPY", "RUB", "CNY", "EUR", "AED", "BRL", "AUD"]
    var price: CoinData = CoinData(rate: 0.0)
    private weak var delegate: CryptoAndMetalViewModelDelegate?
    private var bitcoinRepository: BitcoinRepositable
    
    init(repository: BitcoinRepositable, delegate: CryptoAndMetalViewModelDelegate) {
        self.bitcoinRepository = repository
        self.delegate = delegate
    }
    
    func fetchBitcoinPrice(for baseCurrency: String) {
        bitcoinRepository.performBitcoinValueRequest(for: baseCurrency,
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
}
