//
//  ViewController.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/04.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import WatchConnectivity

class HomeCurrencyViewController: UIViewController {
    
    @IBOutlet private weak var currencyPickerView: UIPickerView!
    @IBOutlet private weak var currencyTableView: UITableView!
    @IBOutlet private weak var activityLoader: UIActivityIndicatorView!
    
    private var watchSession: WCSession?
    private lazy var viewModel = CurrencyViewModel(repository: CurrencyRepository(),
                                                   authentication: AuthenticationRepository(authenticationReference: Auth.auth()),
                                                   database: DatabaseRepository(databaseReference: Database.database().reference(),
                                                                                storageReference: Storage.storage().reference()),
                                                   delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activateActivityIndicatorView()
        currencyPickerView.setValue(AppColours.primaryPickerColour, forKeyPath: "textColor")
        viewModel.loadUserSettingsFromDatabase()
        setupCurrencyPickerView()
        setupCurrencyTableView()
        currencyTableView.register(CurrencyTableViewCell.nib, forCellReuseIdentifier: CurrencyTableViewCell.identifier)
        
        watchSession = WCSession.default
        watchSession?.delegate = self
        watchSession?.activate()
    }
    
    @IBAction private func refreshButtonPressed(_ sender: UIButton) {
        viewModel.fetchCurrencyListFromDatabase(for: viewModel.convertCurrencyToCode(for: viewModel.retrieveSelectedCurrency))
        viewModel.fetchCurrencyListFromAPI(for: viewModel.convertCurrencyToCode(for: viewModel.retrieveSelectedCurrency))
        sendMessage()
    }
    
    private func setupCurrencyPickerView() {
        currencyPickerView.dataSource = self
        currencyPickerView.delegate = self
    }
    
    private func setupCurrencyTableView() {
        currencyTableView.dataSource = self
        currencyTableView.delegate = self
    }
    
    private func activateActivityIndicatorView() {
        activityLoader.hidesWhenStopped = true
        activityLoader.startAnimating()
    }
}

// MARK: - Table View Methods
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

// MARK: - Picker View Methods
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
        viewModel.fetchCurrencyListFromDatabase(for: viewModel.convertCurrencyToCode(for: viewModel.retrieveSelectedCurrency))
        viewModel.setPrimaryCurrencyCode(for: viewModel.retrieveSelectedCurrency)
        viewModel.fetchCurrencyListFromAPI(for: viewModel.convertCurrencyToCode(for: viewModel.retrieveSelectedCurrency))
    }
}

// MARK: - View Model Delegates
extension HomeCurrencyViewController: ViewModelDelegate {
    
    func bindViewModel() {
        self.currencyTableView.reloadData()
        self.currencyPickerView.reloadAllComponents()
        self.activityLoader.stopAnimating()
        self.sendMessage()
    }
}

// MARK: - Watch Session Functions
extension HomeCurrencyViewController: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }
    func sessionDidBecomeInactive(_ session: WCSession) { }
    func sessionDidDeactivate(_ session: WCSession) { }
    
    private func sendMessage() {
        watchSession?.sendMessage(viewModel.currencyDataModelForWatchApp() ?? ["Not Set": ["greyArrow", "Not Set"]],
                                  replyHandler: nil,
                                  errorHandler: nil)
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        DispatchQueue.main.async {
            if let value = message["getExchangeRate"] as? String {
                self.viewModel.selectedCurrency = value
                self.viewModel.fetchCurrencyListFromDatabase(for: self.viewModel.convertCurrencyToCode(for: self.viewModel.retrieveSelectedCurrency))
                self.viewModel.setPrimaryCurrencyCode(for: self.viewModel.retrieveSelectedCurrency)
                self.viewModel.fetchCurrencyListFromAPI(for: self.viewModel.convertCurrencyToCode(for: self.viewModel.retrieveSelectedCurrency))
            }
        }
    }
}
