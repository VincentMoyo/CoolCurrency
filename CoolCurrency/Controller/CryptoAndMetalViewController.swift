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
import WatchConnectivity

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
    @IBOutlet private weak var activityLoader: UIActivityIndicatorView!
    
    private var watchSession: WCSession?
    private lazy var viewModel = CryptoAndMetalViewModel(repositoryCryptoAndMetals: CryptoAndMetalsRepositorys(),
                                                         database: CryptoDatabaseRepository(databaseReference: Database.database().reference()),
                                                         authentication: CryptoAuthenticationRepository(authenticationReference: Auth.auth()),
                                                         delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activateActivityIndicatorView()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.setValue(AppColours.primaryPickerColour, forKeyPath: "textColor")
        viewModel.loadDefaultCurrency()
        
        watchSession = WCSession.default
        watchSession?.delegate = self
        watchSession?.activate()
    }
    
    @IBAction private func refreshButtonPressed(_ sender: UIButton) {
        viewModel.fetchBitcoinAndMetalPrices(for: viewModel.selectedCurrency)
    }
    
    private func activateActivityIndicatorView() {
        activityLoader.hidesWhenStopped = true
        activityLoader.startAnimating()
    }
}

// MARK: - Picker View Methods
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

// MARK: - View Model Delegate
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
        activityLoader.stopAnimating()
        sendBitcoinMessage()
        sendPreciousMinerals()
    }
}

// MARK: - Watch Session Functions
extension CryptoAndMetalViewController: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }
    func sessionDidBecomeInactive(_ session: WCSession) { }
    func sessionDidDeactivate(_ session: WCSession) { }
    
    private func sendBitcoinMessage() {
        watchSession?.sendMessage(viewModel.retrieveBitcoinArray, replyHandler: nil, errorHandler: nil)
    }
    
    private func sendPreciousMinerals() {
        watchSession?.sendMessage(viewModel.retrievePreciousMineralsArray, replyHandler: nil, errorHandler: nil)
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        DispatchQueue.main.async {
            if let value = message["getBitcoinRate"] as? Bool {
                if value {
                    self.viewModel.fetchBitcoinPrice(for: self.viewModel.selectedCurrency)
                }
            }
            if let value = message["getPreciousMinerals"] as? Bool {
                if value {
                    self.viewModel.fetchPriceOfMetals(for: self.viewModel.selectedCurrency)
                }
            }
        }
    }
}
