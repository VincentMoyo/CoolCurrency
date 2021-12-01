//
//  LeadershipBoardInterfaceController.swift
//  CoolCurrencyWatchApp WatchKit Extension
//
//  Created by Vincent Moyo on 2021/12/01.
//

import WatchKit
import Foundation
import WatchConnectivity

class LeadershipBoardInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var leadershipBoardTable: WKInterfaceTable!
    private var watchSession: WCSession?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        watchSession = WCSession.default
        watchSession?.delegate = self
        watchSession?.activate()
        
        let data: [String: Any] = ["getScores": true]
        watchSession?.sendMessage(data, replyHandler: nil, errorHandler: nil)
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
}

extension LeadershipBoardInterfaceController: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        if let messages = message as? [String: [String]] {
            var counter = 0
            let sortedMessage = messages.sorted {
                return $0.value[0] < $1.value[0]
            }
            
            leadershipBoardTable.setNumberOfRows(sortedMessage.count, withRowType: "leadershipBoardCell")
            for _ in sortedMessage {
                let row = leadershipBoardTable.rowController(at: counter) as? LeadershipBoardRowController
                row?.nameLabel.setText("\(sortedMessage[counter].key)")
                row?.positionLabel.setText("\(sortedMessage[counter].value[0]).")
                row?.scoreLabel.setText("\(sortedMessage[counter].value[1])/\(sortedMessage[counter].value[2])")
                counter += 1
            }
        }
    }
}
