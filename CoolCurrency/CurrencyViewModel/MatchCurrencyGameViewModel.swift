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
    
    func checkIfCorrect() -> Bool {
        if selectedFlag == selectedSymbol {
            return true
        } else {
            return false
        }
    }
}
