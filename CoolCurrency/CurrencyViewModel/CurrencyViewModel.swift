//
//  CurrencyViewModel.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/06.
//

import Foundation

enum CurrencyName: String {
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
    private(set) var currencyList: [String: Double] = [:]
    private var secondaryCurrencyValue = 0.0
    private var primaryCurrencyCode = ""
    private var secondaryCurrencyCode = ""
    private var primaryCurrencyFlagName = ""
    private var secondaryCurrencyFlagName = ""
    
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
    func convertIndexToCurrencyName(at index: Int) -> String {
        if let newIndex = Array(currencyList.keys)[safe: index] {
            if let newCurrency = CurrencyName(rawValue: newIndex) {
                return fetchCurrencyFlagName(at: newCurrency)
            }
        }
        return ""
    }
    
    func fetchCurrencyFlagName(at newCurrency: CurrencyName) -> String {
        switch newCurrency {
        case .pound:
            return "BritishFlag"
        case .dollar:
            return "UnitedStatesFlag"
        case .rupee:
            return "IndianFlag"
        case .pula:
            return "BostwanaFlag"
        case .canadianDollar:
            return "CanadianFlag"
        case .cedi:
            return "GhanianFlag"
        case .rand:
            return "SouthAfricanFlag"
        case .yen:
            return "JapaneseFlag"
        case .ruble:
            return "RussianFlag"
        case .yuan:
            return "ChineseFlag"
        case .euros:
            return "EuroFlag"
        case .dirham:
            return "unitedArabFlag"
        case .real:
            return "BrazilianFlag"
        case .australianDollar:
            return "AustralianFlag"
        }
    }
    
    func convertCurrencyToCode(for currency: String) -> String {
        let newCurrency = CurrencyName(rawValue: currency)
        switch newCurrency {
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
        case .none:
            return ""
        }
    }
    
    func fetchConversionCurrencyData() -> ConvertCurrencyDataModel {
        let dataModel = ConvertCurrencyDataModel(primaryCurrentName: primaryCurrencyCode,
                                                 primaryCurrencyFlagName: primaryCurrencyFlagName,
                                                 secondCurrency: secondaryCurrencyValue,
                                                 secondCurrentName: secondaryCurrencyCode,
                                                 secondaryCurrencyFlagName: secondaryCurrencyFlagName)
        return dataModel
    }
    
    func setPrimaryCurrencyCode(for codeValue: String) {
        primaryCurrencyCode = convertCurrencyToCode(for: codeValue)
        if let newCodeValue = CurrencyName(rawValue: codeValue) {
            primaryCurrencyFlagName = fetchCurrencyFlagName(at: newCodeValue)
        }
    }
    
    func setSecondaryCurrency(at index: Int) {
        secondaryCurrencyCode = convertCurrencyToCode(for: Array(currencyList.keys)[index])
        secondaryCurrencyValue = Array(currencyList.values)[index]
        secondaryCurrencyFlagName = convertIndexToCurrencyName(at: index)
    }
    
    private func convertIndexToCurrencyName(at index: Int) -> CurrencyName {
        if let newIndex = Array(currencyList.keys)[safe: index] {
            if let newCurrency = CurrencyName(rawValue: newIndex) {
                return newCurrency
            }
        }
        return CurrencyName(rawValue: "")!
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

extension CurrencyViewModel {
    
    func fetchCurrencyName(at index: Int) -> String? {
        Array(currencyList.keys)[safe: index]
    }
    
    func fetchCurrencyValue(at index: Int) -> Double? {
        Array(currencyList.values)[safe: index]
    }
}

extension CurrencyViewModel {
    
    func currencyDataModel(at index: Int) -> CurrencyDataModel? {
        guard let newCurrencyName = fetchCurrencyName(at: index),
              let newCurrencyValue = fetchCurrencyValue(at: index) else { return nil }
        
        return CurrencyDataModel(currencyFlagName: convertIndexToCurrencyName(at: index),
                                 currencyName: newCurrencyName,
                                 currencyIncreaseIndicator: true,
                                 currencyValue: String(newCurrencyValue))
    }
}
