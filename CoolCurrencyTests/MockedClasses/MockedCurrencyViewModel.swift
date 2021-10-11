//
//  MockedCurrencyViewModels.swift
//  CoolCurrencyTests
//
//  Created by Vincent Moyo on 2021/10/11.
//

import Foundation
@testable import CoolCurrency

class MockedCurrencyViewModel: CurrencyViewModiable {
    
    var currencyList: [String: Double] = [:]
    private var currencyRepository: CurrencyRepositable
    private var response: CurrencyResponseModel?
    
    init(repository: CurrencyRepositable) {
        self.currencyRepository = repository
    }
    
    func fetchCurrencyList(for baseCurrency: String) {
        currencyRepository.performCurrencyRequest(for: baseCurrency,
                                                     completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.response = response
                self?.setCurrencyDataList(currencyData: response.response.rates)
            case .failure(_):
                return
            }
        })
    }
    
    internal func setCurrencyDataList(currencyData: Rates) {
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
    
    internal func roundOffCurrency(for currency: Double) -> Double {
        Double(round(100 * (1 / currency))/100)
    }
}
