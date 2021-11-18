//
//  MatchCurrencyGameViewModel.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/11/11.
//

import Foundation

class MatchCurrencyGameViewModel {
    
    var selectedFlag = "FlagNotSet"
    var selectedSymbol = "SymbolNotSet"
    private var counter = 0
    private var correctAnswer = 0
    
    let listOfCountries: [String: String] = ["Britain": "BritishFlag",
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
        selectedFlag == selectedSymbol ? true : false
    }
    
    var retrieveCorrectAnswer: String {
        "\(correctAnswer) / 5"
    }
    
    func shouldDisplayAnswer() -> Bool {
        counter += 1
        if counter < 5 {
            if selectedFlag == selectedSymbol {
                correctAnswer += 1
            }
            return false
        } else if counter == 5 {
            if selectedFlag == selectedSymbol {
                correctAnswer += 1
            }
            return true
        } else {
            return true
        }
    }
    
    func resetScore() {
        counter = 0
        correctAnswer = 0
    }
}
