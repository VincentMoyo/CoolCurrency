//
//  LeadershipBoardRowController.swift
//  CoolCurrencyWatchApp WatchKit Extension
//
//  Created by Vincent Moyo on 2021/12/01.
//

import UIKit
import WatchKit

class LeadershipBoardRowController: NSObject {
    
    @IBOutlet private var positionLabel: WKInterfaceLabel!
    @IBOutlet private var nameLabel: WKInterfaceLabel!
    @IBOutlet private var scoreLabel: WKInterfaceLabel!
    
    func configure(with model: LeaderBoardDataModel) {
        positionLabel.setText(model.position)
        nameLabel.setText(model.name)
        scoreLabel.setText(model.score)
    }
}
