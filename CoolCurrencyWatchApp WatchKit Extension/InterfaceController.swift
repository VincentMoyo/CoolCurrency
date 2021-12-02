//
//  InterfaceController.swift
//  CoolCurrencyWatchApp WatchKit Extension
//
//  Created by Vincent Moyo on 2021/11/29.
//

import WatchKit
import Foundation
import UIKit

class InterfaceController: WKInterfaceController {
    
    override func awake(withContext context: Any?) { }
    override func willActivate() { }
    override func didDeactivate() { }
    
    let currencyArray = [
        "Pound",
        "Dollar",
        "Rupee",
        "Pula",
        "canadianDollar",
        "Cedi",
        "Rand",
        "Yen",
        "Ruble",
        "Yuan",
        "euros",
        "Dirham",
        "Real",
        "australianDollar"
    ]
    
    @IBAction func exchangeRatePressed() {
        
        var actions: [WKAlertAction] = []
        
        for currency in currencyArray {
            actions.append(alertAction(for: currency))
        }
        
        presentAlert(withTitle: "Choose Currency",
                     message: "Select Default Currency",
                     preferredStyle: .alert, actions: actions)
    }
    
    @IBAction func cryptoPressed() {
        self.pushController(withName: "crypto", context: nil)
    }
    
    @IBAction func mineralsPressed() {
        self.pushController(withName: "minerals", context: nil)
    }
    
    @IBAction func leadershipBoardPressed() {
        self.pushController(withName: "leadershipBoard", context: nil)
    }
    
    private func alertAction(for currency: String) -> WKAlertAction {
        let rateController = { self.pushController(withName: "rates", context: currency) }
        return WKAlertAction(title: currency, style: .default, handler: rateController)
    }
}
