//
//  ViewController.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/04.
//

import UIKit

class HomeCurrencyViewController: UIViewController, CurrencyViewModelDelegate {

    private lazy var viewModel = CurrencyViewModel(repository: CurrencyRepository(), delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchCurrencyList(for: "ZAR")
    }
    
    func bindViewModel() {
        print(viewModel.currencyList)
    }
}
