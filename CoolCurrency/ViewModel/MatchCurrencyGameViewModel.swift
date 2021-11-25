//
//  MatchCurrencyGameViewModel.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/11/11.
//

import Foundation

enum CheckCounter: String {
    case lowerThanFive
    case equalToFive
    case higherThanFive
}

class MatchCurrencyGameViewModel {
    
    var selectedFlag = "FlagNotSet"
    var selectedSymbol = "SymbolNotSet"
    private var positionNumber = 0
    private var userScoreList: [LeadershipBoardDataModel] = []
    private var counter = 0
    private var totalCorrectAnswers = 0
    private var totalScores = 0
    private var firstName: String?
    private var userNumber: Int?
    private var userSettingsList: [String: String] = [:]
    private var databaseRepository: DatabaseRepositable
    private var authenticationRepository: AuthenticationRepositable
    private weak var delegate: ViewModelDelegate?
    
    let listOfCountries: [String: String] = ["Britain": "BritishFlag",
                                             "UnitedStates": "UnitedStatesFlag",
                                             "India": "IndianFlag",
                                             "Botswana": "BostwanaFlag",
                                             "Canada": "CanadianFlag",
                                             "Ghana": "GhanianFlag",
                                             "SouthAfrica": "SouthAfricanFlag",
                                             "Japan": "JapaneseFlag",
                                             "Russia": "RussianFlag",
                                             "China": "ChineseFlag",
                                             "Euro": "EuroFlag",
                                             "UnitedArab": "unitedArabFlag",
                                             "Brazil": "BrazilianFlag",
                                             "Australia": "AustralianFlag"]
    
    let listOfCurrencySymbols: [String: String] = ["Britain": "PoundSymbol",
                                                   "UnitedStates": "USDollarSymbol",
                                                   "India": "RupeeSymbol",
                                                   "Botswana": "PulaSymbol",
                                                   "Canada": "CanadianDollarSymbol",
                                                   "Ghana": "CediSymbol",
                                                   "SouthAfrica": "RandSymbol",
                                                   "Japan": "YenSymbol",
                                                   "Russia": "RubleSymbol",
                                                   "China": "YuanSymbol",
                                                   "Euro": "EuroSymbol",
                                                   "UnitedArab": "DirhamSymbol",
                                                   "Brazil": "RealSymbol",
                                                   "Australia": "AustrialianDollarSymbol"]
    
    init(databaseRepository: DatabaseRepositable, authenticationRepository: AuthenticationRepositable, delegate: ViewModelDelegate) {
        self.databaseRepository = databaseRepository
        self.authenticationRepository = authenticationRepository
        self.delegate = delegate
    }
    
    var retrieveUserNumber: Int {
        userNumber ?? userScoreList.count
    }
    
    var retrieveLoadScoreboardLeaders: [LeadershipBoardDataModel] {
        userScoreList.sorted(by: { $0.correctAnswers > $1.correctAnswers })
    }
    
    var retrieveFirstName: String {
        firstName ?? "Unidentified"
    }
    
    var retrieveCorrectAnswer: String {
        "\(totalCorrectAnswers) / \(totalScores)"
    }
    
    var retrieveUserScoreListCount: Int {
        userScoreList.count
    }
    
    var retrievePositionNumber: Int {
        positionNumber
    }
    
    func checkIfCorrect() -> Bool {
        selectedFlag == selectedSymbol ? true : false
    }
    
    func resetScore() {
        counter = 0
    }
    
    func resetPosition() {
        positionNumber = 0
    }
    
    func loadUserSettingsFromDatabase() {
        databaseRepository.retrieveUserInformationFromDatabase(userID: authenticationRepository.signedInUserIdentification(),
                                                               completion: { [weak self] result in
            do {
                let newUserDetails = try result.get()
                self?.userSettingsList = newUserDetails
                self?.checkUserList()
                self?.loadUserScoreboardsFromDatabase()
                self?.delegate?.bindViewModel()
            } catch {
                self?.delegate?.showUserErrorMessage(error: error)
            }
        })
    }
    
    func leadershipTableViewCellModel(at index: Int) -> LeadershipBoardDataModel? {
        let sortedData = retrieveLoadScoreboardLeaders
        positionNumber += 1
        return LeadershipBoardDataModel(userNumber: sortedData[index].userNumber,
                                        name: sortedData[index].name,
                                        correctAnswers: sortedData[index].correctAnswers,
                                        totalScore: sortedData[index].totalScore)
    }
    
    func shouldDisplayFinalAnswer() -> Bool {
        counter += 1
        if counter < 5 {
            return checkIfCorrectAnswerForCounter(at: CheckCounter.lowerThanFive)
        } else if counter == 5 {
            return checkIfCorrectAnswerForCounter(at: CheckCounter.equalToFive)
        } else {
            return checkIfCorrectAnswerForCounter(at: CheckCounter.higherThanFive)
        }
    }
    
    private func loadUserScoreboardsFromDatabase() {
        databaseRepository.retrieveUserScoreboards(completion: { [weak self] result in
            switch result {
            case .success(let boardsLeaderArray):
                self?.userScoreList = boardsLeaderArray
                self?.assignSpecificUserScores()
                self?.delegate?.bindViewModel()
            case .failure(let updateToDataError):
                self?.delegate?.showUserErrorMessage(error: updateToDataError)
            }
        })
    }
    
    private func assignSpecificUserScores() {
        userScoreList.forEach { specificUser in
            if specificUser.name == firstName {
                guard let totalScore = Int(specificUser.totalScore), let correctAnswer = Int(specificUser.correctAnswers) else { return }
                totalScores = totalScore
                totalCorrectAnswers = correctAnswer
                userNumber = specificUser.userNumber
            }
        }
    }
    
    private func updateScoreIntoDatabase() {
        guard let userFirstName = firstName else { return }
        databaseRepository.updateUsersScoreboard(SignedInUser: retrieveUserNumber,
                                                 name: userFirstName,
                                                 finalScore: String(totalCorrectAnswers),
                                                 totalScore: String(totalScores)) { [weak self] result in
            switch result {
            case .success(_):
                self?.loadUserSettingsFromDatabase()
            case .failure(let updateToDataError):
                self?.delegate?.showUserErrorMessage(error: updateToDataError)
            }
        }
    }
    
    private func checkIfCorrectAnswerForCounter(at counterCheck: CheckCounter) -> Bool {
        switch counterCheck {
        case .lowerThanFive:
            shouldIncrementCorrectAnswer()
            return false
        case .equalToFive:
            totalScores += 5
            shouldIncrementCorrectAnswer()
            updateScoreIntoDatabase()
            return true
        case .higherThanFive:
            return true
        }
    }
    
    private func shouldIncrementCorrectAnswer() {
        if selectedFlag == selectedSymbol {
            totalCorrectAnswers += 1
        }
    }
    
    private func checkUserList() {
        for (key, value) in userSettingsList {
            switch key {
            case "FirstName":
                firstName = value
            default:
                break
            }
        }
    }
}
