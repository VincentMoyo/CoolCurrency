//
//  ViewController.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/04.
//

import UIKit

class HomeCurrencyViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var currencyPickerView: UIPickerView!
    private lazy var viewModel = CurrencyViewModel(repository: CurrencyRepository(), delegate: self)
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchCurrencyList(for: "ZAR")
        currencyPickerView.dataSource = self
        currencyPickerView.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.currencyList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array(viewModel.currencyList.keys)[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = Array(viewModel.currencyList.keys)[row]
        print(viewModel.convertCurrencyToCode(for: CurrencyCode(rawValue: selectedCurrency)!))
        viewModel.fetchCurrencyList(for: viewModel.convertCurrencyToCode(for: CurrencyCode(rawValue: selectedCurrency)!))
    }
}

extension HomeCurrencyViewController: CurrencyViewModelDelegate {
    
    func showUserErrorMessage(error: Error) {
        let alertController = UIAlertController(title: NSLocalizedString("ERROR", comment: ""),
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""),
                                                style: .default,
                                                handler: nil))
        present(alertController, animated: true)
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
