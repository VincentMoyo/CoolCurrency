//
//  ViewController.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/04.
//

import UIKit

class HomeCurrencyViewController: UIViewController {

    private lazy var viewModel = CurrencyViewModel(repository: CurrencyRepository(),
                                                   delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchCurrencyList(for: "ZAR")
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
    }
}
