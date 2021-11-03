//
//  ViewController.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/04.
//

import UIKit

class HomeCurrencyViewController: UIViewController {
    
    @IBOutlet private weak var currencyPickerView: UIPickerView!
    @IBOutlet private weak var currencyTableView: UITableView!
    
    private lazy var viewModel = CurrencyViewModel(repository: CurrencyRepository(), delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchCurrencyListFromAPI(for: "ZAR")
        setupCurrencyPickerView()
        setupCurrencyTableView()
        currencyPickerView.setValue(UIColor.white, forKeyPath: "textColor")
        currencyTableView.register(CurrencyTableViewCell.nib, forCellReuseIdentifier: CurrencyTableViewCell.identifier)
    }
    
    @IBAction private func refreshButtonPressed(_ sender: UIButton) {
        viewModel.fetchCurrencyListFromDatabase(for: viewModel.convertCurrencyToCode(for: viewModel.selectedCurrency))
        viewModel.fetchCurrencyListFromAPI(for: viewModel.convertCurrencyToCode(for: viewModel.selectedCurrency))
    
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
        guard let newModel = viewModel.currencyDataModel(at: indexPath.row) else { return CurrencyTableViewCell() }
        cell?.configure(with: newModel)
        
        return cell ?? CurrencyTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.setSecondaryCurrency(at: indexPath.row)
        let viewController = CurrencyConversionsViewController()
        viewController.set(viewModel.fetchConversionCurrencyData())
        show(viewController, sender: nil)
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
        viewModel.selectedCurrency = Array(viewModel.currencyList.keys)[row]
        viewModel.fetchCurrencyListFromDatabase(for: viewModel.convertCurrencyToCode(for: viewModel.selectedCurrency))
        viewModel.setPrimaryCurrencyCode(for: viewModel.selectedCurrency)
        viewModel.fetchCurrencyListFromAPI(for: viewModel.convertCurrencyToCode(for: viewModel.selectedCurrency))
    }
}

extension HomeCurrencyViewController: ViewModelDelegate {
    
    func bindViewModel() {
            self.currencyTableView.reloadData()
            self.currencyPickerView.reloadAllComponents()
    }
}
