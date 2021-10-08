//
//  ViewController.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/04.
//

import UIKit

class HomeCurrencyViewController: UIViewController {

    @IBOutlet weak var currencyPickerView: UIPickerView!
    private lazy var viewModel = CurrencyViewModel(repository: CurrencyRepository(), delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchCurrencyList(for: "ZAR")
    }
}

extension HomeCurrencyViewController: CurrencyViewModelDelegate {
    
    func bindViewModel() {
        print(viewModel.currencyList)
    }
}
