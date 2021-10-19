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
    
    init(primaryCurrentName: String,
         secondCurrency: Double,
         secondCurrentName: String) {
        self.primaryCurrencyName =  primaryCurrentName
        self.secondCurrency = secondCurrency
        self.secondCurrencyName = secondCurrentName
    }
}
