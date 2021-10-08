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
        currencyList[Constants.CountryList.kGreatBritishPound] = currencyData.greatBritishPound.roundedOffCurrency()
        currencyList[Constants.CountryList.kUnitedStatesDollar] = currencyData.unitedStatesDollar.roundedOffCurrency()
        currencyList[Constants.CountryList.kIndianRupee] = currencyData.indianRupee.roundedOffCurrency()
        currencyList[Constants.CountryList.kBostwanaPula] = currencyData.bostwanaPula.roundedOffCurrency()
        currencyList[Constants.CountryList.kCanadianDollar] = currencyData.canadianDollar.roundedOffCurrency()
        currencyList[Constants.CountryList.kGhanaCedi] = currencyData.ghanaCedi.roundedOffCurrency()
        currencyList[Constants.CountryList.kSouthAfricanRand] = currencyData.southAfricanRand.roundedOffCurrency()
        currencyList[Constants.CountryList.kJapaneseYen] = currencyData.japaneseYen.roundedOffCurrency()
        currencyList[Constants.CountryList.kRussianRuble] = currencyData.russianRuble.roundedOffCurrency()
        currencyList[Constants.CountryList.kChineseYuan] = currencyData.chineseYuan.roundedOffCurrency()
        currencyList[Constants.CountryList.kEuro] = currencyData.euro.roundedOffCurrency()
        currencyList[Constants.CountryList.kUnitedArabDirham] = currencyData.unitedArabDirham.roundedOffCurrency()
        currencyList[Constants.CountryList.kBrazilianReal] = currencyData.brazilianReal.roundedOffCurrency()
        currencyList[Constants.CountryList.kAustralianDollar] = currencyData.australianDollar.roundedOffCurrency()
    }
}
