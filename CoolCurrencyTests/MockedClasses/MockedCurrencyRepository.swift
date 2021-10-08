//
//  File.swift
//  CoolCurrencyTests
//
//  Created by Vincent Moyo on 2021/10/08.
//

import Foundation
@testable import CoolCurrency

class MockedCurrencyRepository: CurrencyRepositable {
    
    func performCurrencyRequest(for baseCurrency: String, completion: @escaping ListCurrencyResponseModel) {
        
        let data = CurrencyResponseModel(response: Response(base: baseCurrency,
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
    }
}
