//
//  ConvertCurrencyDataModel.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/15.
//

import Foundation

@objcMembers class ConvertCurrencyDataModel: NSObject {
    var primaryCurrencyName: String
    var secondCurrency: Double
    var secondCurrencyName: String
    
    override init() {
        primaryCurrencyName = ""
        secondCurrency = 0.0
        secondCurrencyName = ""
    }
}
