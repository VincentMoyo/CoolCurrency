//
//  MatchCurrencyGameViewController.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/11/10.
//

import UIKit

class MatchCurrencyGameViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet private weak var matchCurrencyPickerView: UIPickerView!
    @IBOutlet weak var finalTitle: UILabel!
    @IBOutlet weak var finalScore: UILabel!
    
    private lazy var viewModel = MatchCurrencyGameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelsHidden(true)
        matchCurrencyPickerView.delegate = self
        matchCurrencyPickerView.dataSource = self
    }
    
    @IBAction func matchButtonPressed(_ sender: UIButton) {
        showUserSuccessAlert(viewModel.checkIfCorrect())
        viewModel.shouldDisplayAnswer() == true ? setLabelsHidden(false) : setLabelsHidden(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 1 {
            return viewModel.listOfCountries.count
        } else {
            return viewModel.listOfCurrencySymbols.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        170
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if component == 1 {
            let countryFlagsView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 110))
            let countryFlagsImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 110))
            
            countryFlagsImageView.image = UIImage(named: Array(viewModel.listOfCountries.values)[row])
            countryFlagsView.addSubview(countryFlagsImageView)
            
            return countryFlagsView
        } else {
            let currencySymbolsView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 110))
            let currencySymbolsImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 110))
            
            currencySymbolsImageView.image = UIImage(named: Array(viewModel.listOfCurrencySymbols.values)[row])
            currencySymbolsView.addSubview(currencySymbolsImageView)
            
            return currencySymbolsView
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 1 {
            viewModel.selectedFlag = Array(viewModel.listOfCountries.keys)[row]
        } else {
            viewModel.selectedSymbol = Array(viewModel.listOfCurrencySymbols.keys)[row]
        }
    }
    
    private func setLabelsHidden (_ hideButton: Bool) {
        finalTitle.isHidden = hideButton
        finalScore.isHidden = hideButton
        finalScore.text = viewModel.retrieveCorrectAnswer
    }
    
    private func resetBackgroundColour(action: UIAlertAction! = nil) {
        view.backgroundColor = UIColor(named: "PrimaryBlue")
    }
    
    private func showUserSuccessAlert(_ isCorrectAnswer: Bool) {
        let title = isCorrectAnswer == true ? "Correct" : "Incorrect"
        let message = isCorrectAnswer == true ? "Correct Flag matched" : "Incorrect Flag matched"
        view.backgroundColor = isCorrectAnswer == true ? .systemGreen : .systemRed
        
        Alerts.showUserSuccessAlertExtension(for: self, forAnswer: isCorrectAnswer, title: title, message: message, action: resetBackgroundColour)
    }
}
