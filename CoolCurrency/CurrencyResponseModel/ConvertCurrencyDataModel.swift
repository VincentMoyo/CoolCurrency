//
//  ConvertCurrencyDataModel.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/15.
//

import Foundation

class ConvertCurrencyDataModel: NSObject {
    @objc var primaryCurrency: Double
    @objc var primaryCurrencyName: String
    @objc var secondCurrency: Double
    @objc var secondCurrencyName: String
    
    override init() {
        primaryCurrency = 0.0
        primaryCurrencyName = ""
        secondCurrency = 0.0
        secondCurrencyName = ""
    }
}
