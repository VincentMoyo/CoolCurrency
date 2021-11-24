//
//  MatchCurrencyGameViewController.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/11/10.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class MatchCurrencyGameViewController: UIViewController {
    
    @IBOutlet private weak var matchCurrencyPickerView: UIPickerView!
    @IBOutlet private weak var finalTitle: UILabel!
    @IBOutlet private weak var finalScore: UILabel!
    @IBOutlet private weak var playAgain: UIButton!
    @IBOutlet private weak var matchSymbolToFlag: UIButton!
    @IBOutlet private weak var scoreBoard: UIView!
    @IBOutlet weak var leadershipBoardTableView: UITableView!
    
    private lazy var viewModel = MatchCurrencyGameViewModel(databaseRepository: DatabaseRepository(databaseReference: Database.database().reference(),
                                                                                                   storageReference: Storage.storage().reference()),
                                                            authenticationRepository: AuthenticationRepository(authenticationReference: Auth.auth()),
                                                            delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelsHidden(true)
        matchCurrencyPickerView.delegate = self
        matchCurrencyPickerView.dataSource = self
        viewModel.loadUserSettingsFromDatabase()
        leadershipBoardTableView.dataSource = self
        leadershipBoardTableView.delegate = self
        leadershipBoardTableView.register(LeadershipBoardTableViewCell.nibs, forCellReuseIdentifier: LeadershipBoardTableViewCell.identifiers)
    }
    
    @IBAction private func matchButtonPressed(_ sender: UIButton) {
        showUserSuccessAlert(viewModel.checkIfCorrect())
        let shouldDisplayAnswer = viewModel.shouldDisplayFinalAnswer()
        setLabelsHidden(!shouldDisplayAnswer)
        setButtonsHidden(shouldDisplayAnswer)
    }
    
    @IBAction private func playAgainPressed(_ sender: UIButton) {
        viewModel.resetScore()
        setLabelsHidden(true)
        setButtonsHidden(false)
    }
    
    private func setLabelsHidden (_ hideButton: Bool) {
        finalTitle.isHidden = hideButton
        finalScore.isHidden = hideButton
        playAgain.isHidden = hideButton
        scoreBoard.isHidden = hideButton
        finalScore.text = viewModel.retrieveCorrectAnswer
    }
    
    private func setButtonsHidden (_ hideButton: Bool) {
        matchSymbolToFlag.isHidden = hideButton
        matchCurrencyPickerView.isHidden = hideButton
    }
    
    private func resetBackgroundColour(action: UIAlertAction! = nil) {
        view.backgroundColor = AppColours.primaryBackgroundColour
    }
    
    private func showUserSuccessAlert(_ isCorrectAnswer: Bool) {
        let title = isCorrectAnswer == true ? "Correct" : "Incorrect"
        let message = isCorrectAnswer == true ? "Correct Flag matched" : "Incorrect Flag matched"
        view.backgroundColor = isCorrectAnswer == true ? .systemGreen : .systemRed
        
        Alerts.showUserSuccessAlertExtension(for: self, forAnswer: isCorrectAnswer, title: title, message: message, action: resetBackgroundColour)
    }
}

// MARK: - Picker View Methods
extension MatchCurrencyGameViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 1 {
            return viewModel.listOfCountries.count
        } else {
            return viewModel.listOfCurrencySymbols.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        170
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if component == 1 {
            let countryFlagsView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 110))
            let countryFlagsImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 110))
            
            countryFlagsImageView.image = UIImage(named: Array(viewModel.listOfCountries.values)[row])
            countryFlagsView.addSubview(countryFlagsImageView)
            
            return countryFlagsView
        } else {
            let currencySymbolsView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 110))
            let currencySymbolsImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 110))
            
            currencySymbolsImageView.image = UIImage(named: Array(viewModel.listOfCurrencySymbols.values)[row])
            currencySymbolsView.addSubview(currencySymbolsImageView)
            
            return currencySymbolsView
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 1 {
            viewModel.selectedFlag = Array(viewModel.listOfCountries.keys)[row]
        } else {
            viewModel.selectedSymbol = Array(viewModel.listOfCurrencySymbols.keys)[row]
        }
    }
}

// MARK: - Table View Methods
extension MatchCurrencyGameViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.retrieveLoadScoreboardLeaders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeadershipTableViewCell", for: indexPath) as? LeadershipBoardTableViewCell
        guard let newModel = viewModel.leadershipTableViewCellModel(at: indexPath.row) else { return LeadershipBoardTableViewCell() }
        cell?.configure(with: newModel)
        
        return cell ?? LeadershipBoardTableViewCell()
    }
}

extension MatchCurrencyGameViewController: ViewModelDelegate {
    
    func bindViewModel() {
        self.leadershipBoardTableView.reloadData()
    }
}
