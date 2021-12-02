//
//  ExchangeRatesInterfaceController.swift
//  CoolCurrencyWatchApp WatchKit Extension
//
//  Created by Vincent Moyo on 2021/11/29.
//

import WatchKit
import Foundation
import WatchConnectivity

class ExchangeRatesInterfaceController: WKInterfaceController {
    
    @IBOutlet private weak var currencyTable: WKInterfaceTable!
    private var watchSession: WCSession?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        watchSession = WCSession.default
        watchSession?.delegate = self
        watchSession?.activate()
        
        let data: [String: Any] = ["getExchangeRate": context ?? "Not Set"]
        watchSession?.sendMessage(data, replyHandler: nil, errorHandler: nil)
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
}

extension ExchangeRatesInterfaceController: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        if let messages = message as? [String: [String]] {
            currencyTable.setNumberOfRows(messages.count, withRowType: "currencyCell")
            var counter = 0
            for _ in messages {
                let row = currencyTable.rowController(at: counter) as? ExchangeRateRowController
                let newModel = ExchangeRateDataModel(currencyCode: Array(messages.keys)[counter],
                                                     currencyValue: Array(messages.values)[counter][1],
                                                     currencyIndicator: Array(messages.values)[counter][0])
                row?.configure(with: newModel)
                counter += 1
            }
        }
    }
}
