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

enum CheckChangeCurrentRate: String {
    case increased
    case equal
    case decreased
}

class CurrencyViewModel: CurrencyViewModiable {
    
    var selectedCurrency: String?
    private var defaultCurrency: String?
    private var currencyRepository: CurrencyRepositable
    private weak var delegate: ViewModelDelegate?
    private var response: CurrencyResponseModel?
    private(set) var currencyList: [String: Double] = [:]
    private var userSettingsList: [String: String] = [:]
    private var previousCurrencyList: [String: Double] = [:]
    private var secondaryCurrencyValue = 0.0
    private var primaryCurrencyCode = ""
    private var secondaryCurrencyCode = ""
    private var primaryCurrencyFlagName = ""
    private var secondaryCurrencyFlagName = ""
    private let databaseRepository: DatabaseRepositable
    private let authenticationRepository: AuthenticationRepositable
    
    init(repository: CurrencyRepositable,
         authentication: AuthenticationRepositable,
         database: DatabaseRepositable,
         delegate: ViewModelDelegate) {
        self.currencyRepository = repository
        self.authenticationRepository = authentication
        self.databaseRepository = database
        self.delegate = delegate
    }
    
    var retrieveDefaultCurrency: String {
        defaultCurrency ?? "Dollar"
    }
    
    var retrieveSelectedCurrency: String {
        selectedCurrency ?? "Dollar"
    }
    
    private var retrieveSelectedCurrencyCode: String {
        convertCurrencyToCode(for: retrieveSelectedCurrency)
    }
    
    func fetchConversionCurrencyData() -> ConvertCurrencyDataModel {
        ConvertCurrencyDataModel(primaryCurrentName: primaryCurrencyCode,
                                 primaryCurrencyFlagName: primaryCurrencyFlagName,
                                 secondCurrency: secondaryCurrencyValue,
                                 secondCurrentName: secondaryCurrencyCode,
                                 secondaryCurrencyFlagName: secondaryCurrencyFlagName)
    }
    
    func updateExchangeRateInformation() {
        fetchCurrencyListFromDatabase(for: retrieveSelectedCurrency)
        setPrimaryCurrencyCode(for: retrieveSelectedCurrency)
        fetchCurrencyListFromAPI(for: retrieveSelectedCurrencyCode)
    }
    
    func setSecondaryCurrency(at index: Int) {
        secondaryCurrencyCode = convertCurrencyToCode(for: Array(currencyList.keys)[index])
        secondaryCurrencyValue = Array(currencyList.values)[index]
        secondaryCurrencyFlagName = convertIndexToCurrencyName(at: index)
    }
    
    func currencyDataModel(at index: Int) -> CurrencyDataModel? {
        guard let newCurrencyName = fetchCurrencyName(at: index),
              let newCurrencyValue = fetchCurrencyValue(at: index) else { return nil }
        
        return CurrencyDataModel(currencyFlagName: convertIndexToCurrencyName(at: index),
                                 currencyName: newCurrencyName,
                                 currencyIncreaseIndicator: indicatorIncreased(at: index),
                                 currencyValue: String(newCurrencyValue))
    }
    
    func currencyDataModelForWatchApp() -> [String: [String]]? {
        var currencyListForWatchApp: [String: [String]] = [:]
        
        currencyList.forEach { (key: String, value: Double) in
            currencyListForWatchApp[key] = [retrieveFlagIndicatorName(for: checkForChangeInCurrencyRate(for: key)), String(value)]
        }
        
        return currencyListForWatchApp
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
    
    private func setPrimaryCurrencyCode(for codeValue: String) {
        primaryCurrencyCode = convertCurrencyToCode(for: codeValue)
        if let newCodeValue = CurrencyName(rawValue: codeValue) {
            primaryCurrencyFlagName = fetchCurrencyFlagName(at: newCodeValue)
        }
    }
    
    private func checkUserList() {
        self.userSettingsList.forEach { settings in
            if settings.key == "DefaultCurrency" {
                defaultCurrency = settings.value
            }
        }
    }
    
    private func checkForChangeInCurrencyRate(for value: String) -> Int {
        guard let currentValue = currencyList[value],
              let previousValue = previousCurrencyList[value] else { return 1 }
        
        if currentValue < previousValue {
            return retrieveNumberChangeInRate(at: CheckChangeCurrentRate.decreased)
        } else if currentValue == previousValue {
            return retrieveNumberChangeInRate(at: CheckChangeCurrentRate.equal)
        } else {
            return retrieveNumberChangeInRate(at: CheckChangeCurrentRate.increased)
        }
    }
    
    private func retrieveNumberChangeInRate(at counterCheck: CheckChangeCurrentRate) -> Int {
        switch counterCheck {
        case .increased:
            return 2
        case .equal:
            return 1
        case .decreased:
            return 0
        }
    }
    
    private func indicatorIncreased(at index: Int) -> Int {
        for item in previousCurrencyList {
            if Array(currencyList.keys)[safe: index] == item.key {
                if Array(currencyList.values)[safe: index]! < item.value {
                    return 0
                } else if Array(currencyList.values)[safe: index]! == item.value {
                    return 1
                } else {
                    return 2
                }
            }
        }
        return 1
    }
    
    private func fetchCurrencyFlagName(at newCurrency: CurrencyName) -> String {
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
    
    private func retrieveFlagIndicatorName(for flagName: Int) -> String {
        if flagName == 1 {
            return "greyArrow"
        } else if flagName == 2 {
            return "greenArrow"
        } else {
            return "redArrow"
        }
    }
}

// MARK: - Database Methods
extension CurrencyViewModel {
    
    func loadUserSettingsFromDatabase() {
        databaseRepository.retrieveUserInformationFromDatabase(userID: authenticationRepository.signedInUserIdentification()) { [weak self] result in
            do {
                let newUserDetails = try result.get()
                self?.userSettingsList = newUserDetails
                self?.checkUserList()
                if let newDefaultCurrency = self?.retrieveDefaultCurrency {
                    self?.fetchCurrencyListFromAPI(for: newDefaultCurrency)
                    self?.selectedCurrency = newDefaultCurrency
                }
                self?.delegate?.bindViewModel()
            } catch {
                self?.delegate?.showUserErrorMessage(error: error)
            }
        }
    }
    
    func fetchCurrencyListFromDatabase(for baseCurrency: String) {
        databaseRepository.retrieveCurrencyFromDatabase(baseCurrency: convertCurrencyToCode(for: baseCurrency),
                                                        completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.previousCurrencyList = response
                self?.delegate?.bindViewModel()
            case .failure(let error):
                self?.delegate?.showUserErrorMessage(error: error)
            }
        })
    }
    
    private func insertCurrencyListIntoDatabase(baseCurrency: String) {
        databaseRepository.insertCurrencyIntoDatabase(for: baseCurrency, with: self.currencyList,
                                                         completion: { [weak self] result in
            switch result {
            case .success(_):
                self?.delegate?.bindViewModel()
            case .failure(let error):
                self?.delegate?.showUserErrorMessage(error: error)
            }
        })
    }
}

// MARK: - API requests
extension CurrencyViewModel {
    
    func fetchCurrencyListFromAPI(for baseCurrency: String) {
        currencyRepository.performCurrencyRequest(for: baseCurrency,
                                                     completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.response = response
                self?.setCurrencyDataList(currencyData: response.response.rates)
                self?.insertCurrencyListIntoDatabase(baseCurrency: baseCurrency)
                self?.delegate?.bindViewModel()
            case .failure(let error):
                self?.delegate?.showUserErrorMessage(error: error)
            }
        })
    }
}

// MARK: - Currency Data list Manipulation
extension CurrencyViewModel {
    
    func fetchCurrencyName(at index: Int) -> String? {
        Array(currencyList.keys)[safe: index]
    }
    
    func fetchCurrencyValue(at index: Int) -> Double? {
        Array(currencyList.values)[safe: index]
    }
    
    private func convertIndexToCurrencyName(at index: Int) -> String {
        if let newIndex = Array(currencyList.keys)[safe: index] {
            if let newCurrency = CurrencyName(rawValue: newIndex) {
                return fetchCurrencyFlagName(at: newCurrency)
            }
        }
        return ""
    }
    
    private func convertIndexToCurrencyName(at index: Int) -> CurrencyName {
        if let newIndex = Array(currencyList.keys)[safe: index] {
            if let newCurrency = CurrencyName(rawValue: newIndex) {
                return newCurrency
            }
        }
        return CurrencyName(rawValue: "")!
    }
    
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
