//
//  MatchCurrencyGameViewController.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/11/10.
//

import UIKit

class MatchCurrencyGameViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var matchCurrencyPickerView: UIPickerView!
    
    var selectedFlag = ""
    var selectedSymbol = ""
    
    let listOfCountries = ["BritishFlag",
                           "UnitedStatesFlag",
                           "IndianFlag",
                           "BostwanaFlag",
                           "CanadianFlag",
                           "GhanianFlag",
                           "SouthAfricanFlag",
                           "JapaneseFlag",
                           "RussianFlag",
                           "ChineseFlag",
                           "EuroFlag",
                           "unitedArabFlag",
                           "BrazilianFlag",
                           "AustralianFlag"]
    
    let listOfCurrencySymbols = ["AustrialianDollarSymbol",
                                 "YuanSymbol",
                                 "DirhamSymbol",
                                 "CanadianDollarSymbol",
                                 "EuroSymbol",
                                 "PoundSymbol",
                                 "PulaSymbol",
                                 "RealSymbol",
                                 "RubleSymbol",
                                 "RandSymbol",
                                 "RupeeSymbol",
                                 "USDollarSymbol",
                                 "YenSymbol",
                                 "CediSymbol"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        matchCurrencyPickerView.delegate = self
        matchCurrencyPickerView.dataSource = self
    }
    
    @IBAction func matchButtonPressed(_ sender: UIButton) {
        
    }
    
    func matchFlagWithSymbol() -> Bool {
        false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 1 {
            return listOfCountries.count
        } else {
            return listOfCurrencySymbols.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        170
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if component == 1 {
            let myView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 110))
            let myImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 110))
            
            myImageView.image = UIImage(named: listOfCountries[row])
            
            myView.addSubview(myImageView)
            
            return myView
        } else {
            let myView1 = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 110))
            let myImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 110))

            myImageView.image = UIImage(named: listOfCurrencySymbols[row])
            
            myView1.addSubview(myImageView)
            
            return myView1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 1 {
            selectedFlag = listOfCountries[row]
        } else {
            selectedSymbol = listOfCurrencySymbols[row]
        }
    }
}
