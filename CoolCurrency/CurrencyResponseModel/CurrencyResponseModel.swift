//
//  CurrencyAPIFormat.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/05.
//

import Foundation

struct CurrencyResponseModel: Codable {
    let response: Response
}

struct Response: Codable {
    let base: String
    let rates: Rates
}

struct Rates: Codable {
    
    let unitedStatesDollar: Double
    let euro: Double
    let indianRupee: Double
    let bostwanaPula: Double
    let canadianDollar: Double
    let ghanaCedi: Double
    let greatBritishPound: Double
    let japaneseYen: Double
    let russianRuble: Double
    let chineseYuan: Double
    let southAfricanRand: Double
    let unitedArabDirham: Double
    let brazilianReal: Double
    let australianDollar: Double
    
    private enum CodingKeys: String, CodingKey {
        case greatBritishPound = "GBP"
        case unitedStatesDollar = "USD"
        case indianRupee = "INR"
        case bostwanaPula = "BWP"
        case canadianDollar = "CAD"
        case ghanaCedi = "GHS"
        case southAfricanRand = "ZAR"
        case japaneseYen = "JPY"
        case russianRuble = "RUB"
        case chineseYuan = "CNY"
        case euro = "EUR"
        case unitedArabDirham = "AED"
        case brazilianReal = "BRL"
        case australianDollar = "AUD"
    }
}

struct CoinData: Codable {
    let rate: Double
}
