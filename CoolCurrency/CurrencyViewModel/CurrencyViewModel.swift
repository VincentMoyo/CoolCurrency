//
//  CurrencyViewModel.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/06.
//

import Foundation

enum CurrencyCode: String {
    case pound = "Pound"
    case dollar = "Dollar"
    case rupee = "Rupee"
    case pula = "Pula"
    case canadianDollar
    case cedi = "Cedi"
    case rand = "Rand"
    case yen = "Yen"
    case ruble = "Ruble"
    case yuan = "Yuan"
    case euros = "euros"
    case dirham = "Dirham"
    case real = "Real"
    case australianDollar
}

class CurrencyViewModel: CurrencyViewModiable {
    
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
                self?.delegate?.bindViewModel(self!)
            case .failure(let error):
                self?.delegate?.showUserErrorMessage(error: error)
            }
        })
    }
    
    func convertCurrencyToCode(for currency: CurrencyCode) -> String {
        switch currency {
        case .pound:
            return "GBP"
        case .dollar:
            return "USD"
        case .rupee:
            return "INR"
        case .pula:
            return "BWP"
        case .canadianDollar:
            return "CAD"
        case .cedi:
            return "GHS"
        case .rand:
            return "ZAR"
        case .yen:
            return "JPY"
        case .ruble:
            return "RUB"
        case .yuan:
            return "CNY"
        case .euros:
            return "EUR"
        case .dirham:
            return "AED"
        case .real:
            return "BRL"
        case .australianDollar:
            return "AUD"
        }
    }
}

extension CurrencyViewModel {
    
    internal func setCurrencyDataList(currencyData: Rates) {
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
