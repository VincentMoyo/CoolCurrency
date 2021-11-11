//
//  MatchCurrencyGameViewModel.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/11/11.
//

import Foundation

struct MatchCurrencyGameViewModel {
    
    var selectedFlag = "FlagNotSet"
    var selectedSymbol = "SymbolNotSet"
    
    let listOfCountriess: [String: String] = ["Britain": "BritishFlag",
                                             "UnitedStates": "UnitedStatesFlag",
                                             "India": "IndianFlag",
                                             "Botswana": "BostwanaFlag",
                                             "Canada": "CanadianFlag",
                                             "Ghana": "GhanianFlag",
                                             "SouthAfrica": "SouthAfricanFlag",
                                             "Japan": "JapaneseFlag",
                                             "Russia": "RussianFlag",
                                             "China": "ChineseFlag",
                                             "Euro": "EuroFlag",
                                             "UnitedArab": "unitedArabFlag",
                                             "Brazil": "BrazilianFlag",
                                             "Australia": "AustralianFlag"]
    
    let listOfCurrencySymbols: [String: String] = ["Britain": "PoundSymbol",
                                                   "UnitedStates": "USDollarSymbol",
                                                   "India": "RupeeSymbol",
                                                   "Botswana": "PulaSymbol",
                                                   "Canada": "CanadianDollarSymbol",
                                                   "Ghana": "CediSymbol",
                                                   "SouthAfrica": "RandSymbol",
                                                   "Japan": "YenSymbol",
                                                   "Russia": "RubleSymbol",
                                                   "China": "YuanSymbol",
                                                   "Euro": "EuroSymbol",
                                                   "UnitedArab": "DirhamSymbol",
                                                   "Brazil": "RealSymbol",
                                                   "Australia": "AustrialianDollarSymbol"]
    
    func checkIfCorrect() -> Bool {
        if selectedFlag == selectedSymbol {
            return true
        } else {
            return false
        }
    }
}
