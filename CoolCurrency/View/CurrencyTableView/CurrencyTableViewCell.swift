//
//  CurrencyTableViewCell.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/13.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var currencyNameLabel: UILabel!
    @IBOutlet private weak var currencyFlagImageView: UIImageView!
    @IBOutlet private weak var indicatorImageView: UIImageView!
    @IBOutlet private weak var currencyValueLabel: UILabel!
    
    static let identifier = "CurrencyTableViewCell"
    static let nib = UINib(nibName: "CurrencyTableViewCell", bundle: nil)
    
    func configure(with model: CurrencyDataModel) {
        currencyNameLabel.text = model.currencyName
        currencyValueLabel.text = model.currencyValue
        currencyFlagImageView.image = UIImage(named: model.currencyFlagName)
        if model.currencyIncreaseIndicator {
            indicatorImageView.image = UIImage(named: "greenArrow")
        } else {
            indicatorImageView.image = UIImage(named: "redArrow")
        }
    }
}
