//
//  CryptoAndMetalViewController.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/21.
//

import UIKit

class CryptoAndMetalViewController: UIViewController {
    
    @IBOutlet private weak var currencyPicker: UIPickerView!
    @IBOutlet private weak var bitcoinValueLabel: UILabel!
    @IBOutlet private weak var goldValueLabel: UILabel!
    @IBOutlet private weak var platinumValueLabel: UILabel!
    @IBOutlet private weak var silverValueLabel: UILabel!
    @IBOutlet private weak var currencyCodeLabel: UILabel!
    
    private lazy var viewModel = CryptoAndMetalViewModel(repositoryCryptoAndMetals: CryptoAndMetalsRepository(),
                                                         delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.setValue(UIColor.white, forKeyPath: "textColor")
    }
}

extension CryptoAndMetalViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.currencyList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.currencyList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = viewModel.currencyList[row]
        viewModel.fetchBitcoinAndMetalPrices(for: selectedCurrency)
        currencyCodeLabel.text = selectedCurrency
    }
}

extension CryptoAndMetalViewController: CryptoAndMetalViewModelDelegate {
    
    func bindViewModel(_ currencyViewModel: CryptoAndMetalViewModel) {
        guard let platinumPrice = currencyViewModel.retrieveRoundedOffPriceOfPlatinum(),
              let silverPrice = currencyViewModel.retrieveRoundedOffPriceOfSilver(),
              let goldPrice = currencyViewModel.retrieveRoundedOffPriceOfGold() else {
                  return
              }
        
        bitcoinValueLabel.text = String(currencyViewModel.retrieveRoundedOffPriceOfBitcoin())
        platinumValueLabel.text = String(platinumPrice)
        silverValueLabel.text = String(silverPrice)
        goldValueLabel.text = String(goldPrice)
    }
    
}
