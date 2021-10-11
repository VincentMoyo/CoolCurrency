//
//  MockedCurrencyRepository.swift
//  CoolCurrencyTests
//
//  Created by Vincent Moyo on 2021/10/11.
//

import Foundation
@testable import CoolCurrency

class MockedCurrencyRepository: CurrencyRepositable {
    
    func performCurrencyRequest(for baseCurrency: String, completion: @escaping ListCurrencyResponseModel) {
        
        do {
            let newCurrency = try CurrencyCode(rawValue: baseCurrency)!
            let data = CurrencyResponseModel(response: Response(base: newCurrency.rawValue,
                                                                rates: Rates(unitedStatesDollar: 1.1,
                                                                             euro: 1.1,
                                                                             indianRupee: 1.1,
                                                                             bostwanaPula: 1.1,
                                                                             canadianDollar: 1.1,
                                                                             ghanaCedi: 1.1,
                                                                             greatBritishPound: 1.1,
                                                                             japaneseYen: 1.1,
                                                                             russianRuble: 1.1,
                                                                             chineseYuan: 1.1,
                                                                             southAfricanRand: 1.1,
                                                                             unitedArabDirham: 1.1,
                                                                             brazilianReal: 1.1,
                                                                             australianDollar: 1.1)))
            completion(.success(data))
        } catch {
            completion(.failure(error))
        }
    }
}

enum CurrencyCode: String {
    case GBP
    case USD
    case INR
    case BWP
    case CAD
    case GHS
    case ZAR
    case JPY
    case RUB
    case CNY
    case EUR
    case AED
    case BRL
    case AUD
}
