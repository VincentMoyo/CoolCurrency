//
//  UserAlerts.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/11/16.
//

import Foundation
import UIKit

struct Alerts {
    
    static let updateFirstNameMessage = "Set your First Name to complete your profile account setup"
    static let updateLastNameMessage = "Set your Last Name to complete your profile account setup"
    static let resetEmailMessage = "Reset your email and insert a new one"
    static let updateFirstNameTitle = "Set First name"
    static let updateLastNameTitle = "Set Last  name"
    static let resetEmailTitle = "Reset Email"
    
    static func showUserSuccessAlertExtension(for viewController: UIViewController,
                                              forAnswer isCorrectAnswer: Bool,
                                              title: String,
                                              message: String,
                                              action: @escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: action))
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func showUpdateFirstNameAlert(for viewController: UIViewController,
                                         buttonLabelText nameLabel: UIButton? = nil,
                                         updateNamesToDatabase: @escaping (_ newName: String) -> Void) {
        
        setupProfileIntoDatabase(for: viewController,
                                    buttonLabelText: nameLabel,
                                    updateNamesToDatabase: updateNamesToDatabase,
                                    title: updateFirstNameTitle,
                                    message: updateFirstNameMessage)
    }
    
    static func showUpdateLastNameAlert(for viewController: UIViewController,
                                        buttonLabelText nameLabel: UIButton? = nil,
                                        updateNamesToDatabase: @escaping (_ newName: String) -> Void) {
        
        setupProfileIntoDatabase(for: viewController,
                                    buttonLabelText: nameLabel,
                                    updateNamesToDatabase: updateNamesToDatabase,
                                    title: updateLastNameTitle,
                                    message: updateLastNameMessage)
    }
    
    static func showResetEmailAlert(for viewController: UIViewController,
                                    updateNamesToDatabase: @escaping (_ newName: String) -> Void) {
        
        setupProfileIntoDatabase(for: viewController,
                                    updateNamesToDatabase: updateNamesToDatabase,
                                    title: resetEmailTitle,
                                    message: resetEmailMessage)
    }
    
    private static func setupProfileIntoDatabase(for viewController: UIViewController,
                                                 buttonLabelText nameLabel: UIButton? = nil,
                                                 updateNamesToDatabase: @escaping (_ newName: String) -> Void,
                                                 title newTitle: String,
                                                 message newMessage: String) {
        var textField = UITextField()
        let alert = UIAlertController(title: newTitle,
                                      message: newMessage,
                                      preferredStyle: .alert)
        
        let actions = UIAlertAction(title: "Change", style: .default, handler: { (_) in
            guard let newFirstName = textField.text else { return }
            nameLabel?.setTitle(newFirstName, for: .normal)
            updateNamesToDatabase(newFirstName)
        })
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "New Name"
            textField = alertTextField
        }
        
        alert.addAction(actions)
        viewController.present(alert, animated: true, completion: nil)
    }
    
}
