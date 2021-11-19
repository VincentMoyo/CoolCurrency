//
//  ConvertCurrencyDataModel.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/15.
//

import Foundation

@objcMembers class ConvertCurrencyDataModel: NSObject {
    var primaryCurrencyName: String
    var primaryCurrencyFlagName: String
    var secondCurrency: Double
    var secondCurrencyName: String
    var secondaryCurrencyFlagName: String
    
    init(primaryCurrentName: String,
         primaryCurrencyFlagName: String,
         secondCurrency: Double,
         secondCurrentName: String,
         secondaryCurrencyFlagName: String) {
        self.primaryCurrencyName =  primaryCurrentName
        self.primaryCurrencyFlagName = primaryCurrencyFlagName
        self.secondCurrency = secondCurrency
        self.secondCurrencyName = secondCurrentName
        self.secondaryCurrencyFlagName = secondaryCurrencyFlagName
    }
}
