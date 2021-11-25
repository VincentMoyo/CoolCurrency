//
//  LeadershipBoardTableViewCell.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/11/24.
//

import UIKit

class LeadershipBoardTableViewCell: UITableViewCell {

    @IBOutlet private weak var positionNumber: UILabel!
    @IBOutlet private weak var userName: UILabel!
    @IBOutlet private weak var totalCorrectAnswers: UILabel!
    @IBOutlet private weak var totalScore: UILabel!
    
    func configure(with model: LeadershipBoardDataModel, for position: Int) {
        positionNumber.text = "\(position)."
        userName.text = model.name
        totalCorrectAnswers.text = String(model.correctAnswers)
        totalScore.text = String(model.totalScore)
    }
}
