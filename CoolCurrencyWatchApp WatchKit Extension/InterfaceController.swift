//
//  InterfaceController.swift
//  CoolCurrencyWatchApp WatchKit Extension
//
//  Created by Vincent Moyo on 2021/11/29.
//

import WatchKit
import Foundation
import WatchConnectivity
import UIKit

class InterfaceController: WKInterfaceController {
    
    private var watchSession: WCSession?
    
    override func awake(withContext context: Any?) {
        watchSession = WCSession.default
        watchSession?.delegate = self
        watchSession?.activate()
    }
    
    override func willActivate() {
        
    }
    
    override func didDeactivate() {
        
    }
    
    func alertAction(for currency: String) -> WKAlertAction {
        let rateController = { self.pushController(withName: "rates", context: currency) }
        return WKAlertAction(title: currency, style: .default, handler: rateController)
    }
    
    @IBAction func exchangeRatePressed() {
        
        let poundCurrencyAction = alertAction(for: "Pound")
        let dollarCurrencyAction = alertAction(for: "Dollar")
        let rupeeCurrencyAction = alertAction(for: "Rupee")
        let pulaCurrencyAction = alertAction(for: "Pula")
        let canadianDollarCurrencyAction = alertAction(for: "canadianDollar")
        let cediCurrencyAction = alertAction(for: "Cedi")
        let randCurrencyAction = alertAction(for: "Rand")
        let yenCurrencyAction = alertAction(for: "Yen")
        let rubleCurrencyAction = alertAction(for: "Ruble")
        let yuanCurrencyAction = alertAction(for: "Yuan")
        let eurosCurrencyAction = alertAction(for: "euros")
        let dirhamCurrencyAction = alertAction(for: "Dirham")
        let realCurrencyAction = alertAction(for: "Real")
        let autralianDollarCurrencyAction = alertAction(for: "australianDollar")
        
        presentAlert(withTitle: "Choose Currency",
                     message: "Select Default Currency",
                     preferredStyle: .alert, actions: [poundCurrencyAction,
                                                       dollarCurrencyAction,
                                                       rupeeCurrencyAction,
                                                       pulaCurrencyAction,
                                                       canadianDollarCurrencyAction,
                                                       cediCurrencyAction,
                                                       randCurrencyAction,
                                                       yenCurrencyAction,
                                                       rubleCurrencyAction,
                                                       yuanCurrencyAction,
                                                       eurosCurrencyAction,
                                                       dirhamCurrencyAction,
                                                       realCurrencyAction,
                                                       autralianDollarCurrencyAction])
    }
    
    @IBAction func cryptoPressed() {
        self.pushController(withName: "crypto", context: nil)
    }
    
    @IBAction func mineralsPressed() {
    }
}

extension InterfaceController: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        if let message = message["iPhoneMessage"] as? String {
            print(message)
        }
    }
}
