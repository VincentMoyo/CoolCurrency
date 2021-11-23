//
//  MatchCurrencyGameViewModel.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/11/11.
//

import Foundation

enum CheckCounter: String {
    case lowerThanFive
    case equalToFive
    case higherThanFive
}

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
    
    func resetScore() {
        counter = 0
        correctAnswer = 0
    }
    
    func shouldDisplayFinalAnswer() -> Bool {
        counter += 1
        if counter < 5 {
            return checkIfCorrectAnswerForCounter(at: CheckCounter.lowerThanFive)
        } else if counter == 5 {
            return checkIfCorrectAnswerForCounter(at: CheckCounter.equalToFive)
        } else {
            return checkIfCorrectAnswerForCounter(at: CheckCounter.higherThanFive)
        }
    }
    
    private func checkIfCorrectAnswerForCounter(at counterCheck: CheckCounter) -> Bool {
        switch counterCheck {
        case .lowerThanFive:
            shouldIncrementCorrectAnswer()
            return false
        case .equalToFive:
            shouldIncrementCorrectAnswer()
            return true
        case .higherThanFive:
            return true
        }
    }
    
    private func shouldIncrementCorrectAnswer() {
        if selectedFlag == selectedSymbol {
            correctAnswer += 1
        }
    }
}
