//
//  LeadershipBoardTableViewCell.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/11/24.
//

import UIKit

class LeadershipBoardTableViewCell: UITableViewCell {

    @IBOutlet weak var positionNumber: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var totalCorrectAnswers: UILabel!
    @IBOutlet weak var totalScore: UILabel!
    // var counter = 0
    
    static let identifiers = "LeadershipTableViewCell"
    static let nibs = UINib(nibName: "LeadershipTableViewCell", bundle: nil)
    
    func configure(with model: LeadershipBoardDataModel) {
        // counter += 1
        // positionNumber.text = "\(counter)."
        userName.text = model.name
        totalCorrectAnswers.text = model.correctAnswers
        totalScore.text = model.totalScore
    }
}
