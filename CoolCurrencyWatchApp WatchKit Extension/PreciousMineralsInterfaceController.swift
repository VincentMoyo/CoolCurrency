//
//  PreciousMineralsInterfaceController.swift
//  CoolCurrencyWatchApp WatchKit Extension
//
//  Created by Vincent Moyo on 2021/12/01.
//

import WatchKit
import Foundation
import WatchConnectivity

class PreciousMineralsInterfaceController: WKInterfaceController {

    @IBOutlet private weak var goldValue: WKInterfaceLabel!
    @IBOutlet private weak var goldUnitSymbol: WKInterfaceLabel!
    @IBOutlet private weak var platinumValue: WKInterfaceLabel!
    @IBOutlet private weak var platinumUnitSymbol: WKInterfaceLabel!
    @IBOutlet private weak var silverValue: WKInterfaceLabel!
    @IBOutlet private weak var silverUnitSymbol: WKInterfaceLabel!
    
    private var watchSession: WCSession?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        watchSession = WCSession.default
        watchSession?.delegate = self
        watchSession?.activate()
        
        let data: [String: Any] = ["getPreciousMinerals": true]
        watchSession?.sendMessage(data, replyHandler: nil, errorHandler: nil)
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
    
    func assignUnitSymbols(baseUnit unit: String) {
        goldUnitSymbol.setText(unit)
        platinumUnitSymbol.setText(unit)
        silverUnitSymbol.setText(unit)
    }
}

extension PreciousMineralsInterfaceController: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        if let message = message["PreciousMinerals"] as? [String] {
            assignUnitSymbols(baseUnit: message[0])
            goldValue.setText(message[1])
            platinumValue.setText(message[2])
            silverValue.setText(message[3])
        }
    }
}
