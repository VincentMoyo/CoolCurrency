//
//  ViewController.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/04.
//

import UIKit

class HomeCurrencyViewController: UIViewController, CurrencyViewModelDelegate {

    @IBOutlet weak var currencyPickerView: UIPickerView!
    private lazy var viewModel = CurrencyViewModel(repository: CurrencyRepository(), delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchCurrencyList(for: "ZAR")
        currencyPickerView.dataSource = self
        currencyPickerView.delegate = self
    }
    
    func bindViewModel() {
        print(viewModel.currencyList)
        viewModel.modelLoad = { result in
            if result {
                DispatchQueue.main.async {
                    self.currencyPickerView.reloadAllComponents()
                }
            }
        }
    }
}

extension HomeCurrencyViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.currencyList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        Array(viewModel.currencyList.keys)[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = Array(viewModel.currencyList.keys)[row]
        print(viewModel.convertCurrencyToCode(for: CurrencyCode(rawValue: selectedCurrency)!))
        viewModel.fetchCurrencyList(for: viewModel.convertCurrencyToCode(for: CurrencyCode(rawValue: selectedCurrency)!))
    }
}
