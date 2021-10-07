//
//  CurrencyViewModel.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/06.
//

import Foundation

class CurrencyViewModel {
    
    private var currencyRepository: CurrencyRepositable
    private weak var delegate: CurrencyViewModelDelegate?
    private var response: CurrencyResponseModel?
    private (set) var currencyList: [String: Double] = [:]
    var modelLoad: ((Bool) -> Void)?
    
    init(repository: CurrencyRepositable, delegate: CurrencyViewModelDelegate) {
        self.currencyRepository = repository
        self.delegate = delegate
    }
    
    func fetchCurrencyList(for baseCurrency: String) {
        currencyRepository.performCurrencyRequest(for: baseCurrency,
                                                     completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.response = response
                self?.setCurrencyDataList(currencyData: response.response.rates)
                self?.delegate?.bindViewModel()
                self?.modelLoad?(true)
            case .failure(let error):
                self?.delegate?.showUserErrorMessage(error: error)
            }
        })
    }
}

extension CurrencyViewModel {
    
    private func setCurrencyDataList(currencyData: Rates) {
        currencyList[Constants.CountryList.kGreatBritishPound] = roundOffCurrency(for: currencyData.greatBritishPound)
        currencyList[Constants.CountryList.kUnitedStatesDollar] = roundOffCurrency(for: currencyData.unitedStatesDollar)
        currencyList[Constants.CountryList.kIndianRupee] = roundOffCurrency(for: currencyData.indianRupee)
        currencyList[Constants.CountryList.kBostwanaPula] = roundOffCurrency(for: currencyData.bostwanaPula)
        currencyList[Constants.CountryList.kCanadianDollar] = roundOffCurrency(for: currencyData.canadianDollar)
        currencyList[Constants.CountryList.kGhanaCedi] = roundOffCurrency(for: currencyData.ghanaCedi)
        currencyList[Constants.CountryList.kSouthAfricanRand] = roundOffCurrency(for: currencyData.southAfricanRand)
        currencyList[Constants.CountryList.kJapaneseYen] = roundOffCurrency(for: currencyData.japaneseYen)
        currencyList[Constants.CountryList.kRussianRuble] = roundOffCurrency(for: currencyData.russianRuble)
        currencyList[Constants.CountryList.kChineseYuan] = roundOffCurrency(for: currencyData.chineseYuan)
        currencyList[Constants.CountryList.kEuro] = roundOffCurrency(for: currencyData.euro)
        currencyList[Constants.CountryList.kUnitedArabDirham] = roundOffCurrency(for: currencyData.unitedArabDirham)
        currencyList[Constants.CountryList.kBrazilianReal] = roundOffCurrency(for: currencyData.brazilianReal)
        currencyList[Constants.CountryList.kAustralianDollar] = roundOffCurrency(for: currencyData.australianDollar)
    }
    
    private func roundOffCurrency(for currency: Double) -> Double {
        Double(round(100 * (1 / currency))/100)
    }
}
