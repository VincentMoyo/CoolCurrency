//
//  MatchCurrencyGameViewController.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/11/10.
//

import UIKit

class MatchCurrencyGameViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var matchCurrencyPickerView: UIPickerView!
    
    private lazy var viewModel = MatchCurrencyGameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        matchCurrencyPickerView.delegate = self
        matchCurrencyPickerView.dataSource = self
    }
    
    @IBAction func matchButtonPressed(_ sender: UIButton) {
        showUserSuccessAlert(viewModel.checkIfCorrect())
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 1 {
            return Constants.List.listOfCountries.count
        } else {
            return Constants.List.listOfCurrencySymbols.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        170
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if component == 1 {
            let countryFlagsView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 110))
            let countryFlagsImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 110))
            
            countryFlagsImageView.image = UIImage(named: Array(Constants.List.listOfCountries.values)[row])
            countryFlagsView.addSubview(countryFlagsImageView)
            
            return countryFlagsView
        } else {
            let currencySymbolsView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 110))
            let currencySymbolsImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 110))
            
            currencySymbolsImageView.image = UIImage(named: Array(Constants.List.listOfCurrencySymbols.values)[row])
            currencySymbolsView.addSubview(currencySymbolsImageView)
            
            return currencySymbolsView
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 1 {
            viewModel.selectedFlag = Array(Constants.List.listOfCountries.keys)[row]
        } else {
            viewModel.selectedSymbol = Array(Constants.List.listOfCurrencySymbols.keys)[row]
        }
    }
    
    private func resetBackgroundColour(action: UIAlertAction! = nil) {
        view.backgroundColor = UIColor(red: 26, green: 5, blue: 9, alpha: 0)
    }
    
    private func showUserSuccessAlert(_ isCorrectAnswer: Bool) {
        
        let title = isCorrectAnswer == true ? "Correct" : "Incorrect"
        let message = isCorrectAnswer == true ? "Correct Flag matched" : "Incorrect Flag matched"
        view.backgroundColor = isCorrectAnswer == true ? .systemGreen : .systemRed
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK",
                                                style: .default,
                                                handler: resetBackgroundColour))
        
        present(alertController, animated: true)
    }
}
