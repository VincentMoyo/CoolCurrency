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

    @IBOutlet weak var currencyTable: WKInterfaceTable!
    private var watchSession: WCSession?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        watchSession = WCSession.default
        watchSession?.delegate = self
        watchSession?.activate()
        let data: [String: Any] = ["getExchangeRate": context ?? "Rand"]
        
        watchSession?.sendMessage(data, replyHandler: nil, errorHandler: nil)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
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
                let row = currencyTable.rowController(at: counter) as? RowController
                row?.currencyCodeLabel.setText(Array(messages.keys)[counter])
                row?.currencyValueLabel.setText(Array(messages.values)[counter][1])
                row?.currencyIndicator.setImageNamed(Array(messages.values)[counter][0])
                counter += 1
            }
        }
    }
}
