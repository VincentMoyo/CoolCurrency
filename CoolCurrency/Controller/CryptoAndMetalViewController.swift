//
//  CryptoAndMetalViewController.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/21.
//

import UIKit
import CoolCurrencyFramework
import FirebaseAuth
import FirebaseDatabase

class CryptoAndMetalViewController: UIViewController {
    
    @IBOutlet private weak var currencyPicker: UIPickerView!
    @IBOutlet private weak var bitcoinValueLabel: UILabel!
    @IBOutlet private weak var goldValueLabel: UILabel!
    @IBOutlet private weak var platinumValueLabel: UILabel!
    @IBOutlet private weak var silverValueLabel: UILabel!
    @IBOutlet private weak var currencyCodeLabel: UILabel!
    @IBOutlet private weak var goldUnitMeasurement: UILabel!
    @IBOutlet private weak var platinumUnitMeasurement: UILabel!
    @IBOutlet private weak var silverUnitMeasurement: UILabel!
    
    private lazy var viewModel = CryptoAndMetalViewModel(repositoryCryptoAndMetals: CryptoAndMetalsRepositorys(),
                                                         database: CryptoDatabaseRepository(databaseReference: Database.database().reference()),
                                                         authentication: CryptoAuthenticationRepository(authenticationReference: Auth.auth()),
                                                         delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.setValue(UIColor.white, forKeyPath: "textColor")
        viewModel.loadDefaultCurrency()
    }
    
    @IBAction private func refreshButtonPressed(_ sender: UIButton) {
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
    }
}

extension CryptoAndMetalViewController: ViewModelDelegates {
    
    func bindViewModel() {
        currencyCodeLabel.text = viewModel.selectedCurrency
        goldUnitMeasurement.text = viewModel.unitMeasurementSymbol
        platinumUnitMeasurement.text = viewModel.unitMeasurementSymbol
        silverUnitMeasurement.text = viewModel.unitMeasurementSymbol
        bitcoinValueLabel.text = viewModel.retrieveRoundedOffPriceOfBitcoin
        platinumValueLabel.text = viewModel.retrieveRoundedOffPriceOfPlatinum
        silverValueLabel.text = viewModel.retrieveRoundedOffPriceOfSilver
        goldValueLabel.text = viewModel.retrieveRoundedOffPriceOfGold
    }
}
