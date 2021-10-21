//
//  CryptoAndMetalViewController.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/21.
//

import UIKit

class CryptoAndMetalViewController: UIViewController {

    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var bitcoinValueLabel: UILabel!
    @IBOutlet weak var goldValueLabel: UILabel!
    @IBOutlet weak var platinumValueLabel: UILabel!
    @IBOutlet weak var silverValueLabel: UILabel!
    
    private lazy var viewModel = CryptoAndMetalViewModel(repository: BitcoinRepository(), delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
    }
}

extension CryptoAndMetalViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = viewModel.currencyArray[row]
        viewModel.fetchBitcoinPrice(for: selectedCurrency)
    }
}

extension CryptoAndMetalViewController: CryptoAndMetalViewModelDelegate {
    
    func bindViewModel(_ currencyViewModel: CryptoAndMetalViewModel) {
        bitcoinValueLabel.text = String(currencyViewModel.price.rate)
    }
    
}
