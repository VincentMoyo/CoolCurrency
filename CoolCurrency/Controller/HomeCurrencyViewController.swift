//
//  ViewController.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/04.
//

import UIKit

class HomeCurrencyViewController: UIViewController {
    
    @IBOutlet weak var currencyPickerView: UIPickerView!
    @IBOutlet weak var currencyTableView: UITableView!
    
    private lazy var viewModel = CurrencyViewModel(repository: CurrencyRepository(), delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchCurrencyList(for: "ZAR")
        setupCurrencyPickerView()
        setupCurrencyTableView()
        currencyTableView.register(CurrencyTableViewCell.nib, forCellReuseIdentifier: CurrencyTableViewCell.identifier)
    }
    
    private func setupCurrencyPickerView() {
        currencyPickerView.dataSource = self
        currencyPickerView.delegate = self
    }
    
    private func setupCurrencyTableView() {
        currencyTableView.dataSource = self
        currencyTableView.delegate = self
    }
    
}

extension HomeCurrencyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.currencyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyTableViewCell", for: indexPath) as? CurrencyTableViewCell
        let newModel = CurrencyDataModel(currencyFlagName: viewModel.fetchCurrencyFlagName(at: indexPath.row),
                                         currencyName: viewModel.fetchCurrencyName(at: indexPath.row)!,
                                         currencyIncreaseIndicator: true,
                                         currencyValue: String(viewModel.fetchCurrencyValue(at: indexPath.row)!))
        cell?.configure(with: newModel)
        
        return cell ?? CurrencyTableViewCell()
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
        print(viewModel.convertCurrencyToCode(for: selectedCurrency))
        viewModel.fetchCurrencyList(for: viewModel.convertCurrencyToCode(for: selectedCurrency))
    }
}

extension HomeCurrencyViewController: CurrencyViewModelDelegate {
    
    func bindViewModel(_ currencyViewModel: CurrencyViewModel) {
        print(viewModel.currencyList)
        DispatchQueue.main.async {
            self.currencyTableView.reloadData()
            self.currencyPickerView.reloadAllComponents()
        }
    }
}
