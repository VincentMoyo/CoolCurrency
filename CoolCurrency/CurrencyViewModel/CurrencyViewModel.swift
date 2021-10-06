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
            case .failure(let error):
                self?.delegate?.showUserErrorMessage(error: error)
            }
        })
    }
}

extension CurrencyViewModel {
    
    private func setCurrencyDataList(currencyData: Rates) {
        currencyList[Constants.CountryList.kGreatBritishPound] = convertCurrencyAgainstBaseCurrency(for: currencyData.greatBritishPound)
        currencyList[Constants.CountryList.kUnitedStatesDollar] = convertCurrencyAgainstBaseCurrency(for: currencyData.unitedStatesDollar)
        currencyList[Constants.CountryList.kIndianRupee] = convertCurrencyAgainstBaseCurrency(for: currencyData.indianRupee)
        currencyList[Constants.CountryList.kBostwanaPula] = convertCurrencyAgainstBaseCurrency(for: currencyData.bostwanaPula)
        currencyList[Constants.CountryList.kCanadianDollar] = convertCurrencyAgainstBaseCurrency(for: currencyData.canadianDollar)
        currencyList[Constants.CountryList.kGhanaCedi] = convertCurrencyAgainstBaseCurrency(for: currencyData.ghanaCedi)
        currencyList[Constants.CountryList.kSouthAfricanRand] = convertCurrencyAgainstBaseCurrency(for: currencyData.southAfricanRand)
        currencyList[Constants.CountryList.kJapaneseYen] = convertCurrencyAgainstBaseCurrency(for: currencyData.japaneseYen)
        currencyList[Constants.CountryList.kRussianRuble] = convertCurrencyAgainstBaseCurrency(for: currencyData.russianRuble)
        currencyList[Constants.CountryList.kChineseYuan] = convertCurrencyAgainstBaseCurrency(for: currencyData.chineseYuan)
        currencyList[Constants.CountryList.kEuro] = convertCurrencyAgainstBaseCurrency(for: currencyData.euro)
        currencyList[Constants.CountryList.kUnitedArabDirham] = convertCurrencyAgainstBaseCurrency(for: currencyData.unitedArabDirham)
        currencyList[Constants.CountryList.kBrazilianReal] = convertCurrencyAgainstBaseCurrency(for: currencyData.brazilianReal)
        currencyList[Constants.CountryList.kAustralianDollar] = convertCurrencyAgainstBaseCurrency(for: currencyData.australianDollar)
    }
    
    private func convertCurrencyAgainstBaseCurrency(for currency: Double) -> Double {
        Double(round(100 * (1 / currency))/100)
    }
}
