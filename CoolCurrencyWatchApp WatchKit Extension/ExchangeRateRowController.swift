//
//  RowController.swift
//  CoolCurrencyWatchApp WatchKit Extension
//
//  Created by Vincent Moyo on 2021/11/29.
//

import UIKit
import WatchKit

class ExchangeRateRowController: NSObject {
    
    @IBOutlet private var currencyCodeLabel: WKInterfaceLabel!
    @IBOutlet private var currencyValueLabel: WKInterfaceLabel!
    @IBOutlet private var currencyIndicator: WKInterfaceImage!
    
    func configure(with model: ExchangeRateDataModel) {
        currencyCodeLabel.setText(model.currencyCode)
        currencyValueLabel.setText(model.currencyValue)
        currencyIndicator.setImageNamed(model.currencyIndicator)
    }
}
 
