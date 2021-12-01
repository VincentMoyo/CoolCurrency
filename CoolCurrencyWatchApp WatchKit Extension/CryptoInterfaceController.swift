//
//  CryptoInterfaceController.swift
//  CoolCurrencyWatchApp WatchKit Extension
//
//  Created by Vincent Moyo on 2021/12/01.
//

import WatchKit
import Foundation
import WatchConnectivity

class CryptoInterfaceController: WKInterfaceController {

    @IBOutlet private weak var bitcoinValue: WKInterfaceLabel!
    @IBOutlet private weak var bitcoinCurrencyCode: WKInterfaceLabel!
    private var watchSession: WCSession?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        watchSession = WCSession.default
        watchSession?.delegate = self
        watchSession?.activate()
        
        let data: [String: Any] = ["getBitcoinRate": true]
        watchSession?.sendMessage(data, replyHandler: nil, errorHandler: nil)
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
}

extension CryptoInterfaceController: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        if let message = message["Bitcoin"] as? [String] {
            bitcoinValue.setText(message[0])
            bitcoinCurrencyCode.setText(message[1])
        }
    }
}
