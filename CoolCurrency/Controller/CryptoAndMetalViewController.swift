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
    
    @IBAction func refreshButtonPressed(_ sender: UIButton) {
        viewModel.fetchBitcoinAndMetalPrices(for: viewModel.selectedCurrency)
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
        viewModel.selectedCurrency = viewModel.currencyList[row]
        viewModel.fetchBitcoinAndMetalPrices(for: viewModel.selectedCurrency)
        currencyCodeLabel.text = viewModel.selectedCurrency
    }
}

extension CryptoAndMetalViewController: CryptoAndMetalViewModelDelegate {
    
    func bindViewModel() {
        bitcoinValueLabel.text = viewModel.retrieveRoundedOffPriceOfBitcoin
        platinumValueLabel.text = viewModel.retrieveRoundedOffPriceOfPlatinum
        silverValueLabel.text = viewModel.retrieveRoundedOffPriceOfSilver
        goldValueLabel.text = viewModel.retrieveRoundedOffPriceOfGold
    }
}
