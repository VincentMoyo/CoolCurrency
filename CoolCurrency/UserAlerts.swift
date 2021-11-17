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
    static let correctTitle = "Correct"
    
    static func showUpdateFirstNameAlert(for viewController: UIViewController,
                                         buttonLabelText nameLabel: UIButton? = nil,
                                         updateNamesToDatabase: @escaping (_ newName: String) -> Void) {
        
        implementTextFieldAlert(for: viewController,
                                   buttonLabelText: nameLabel,
                                   updateNamesToDatabase: updateNamesToDatabase,
                                   newTitle: updateFirstNameTitle,
                                   newMessage: updateFirstNameMessage)
    }
    
    static func showUpdateLastNameAlert(for viewController: UIViewController,
                                        buttonLabelText nameLabel: UIButton? = nil,
                                        updateNamesToDatabase: @escaping (_ newName: String) -> Void) {
        implementTextFieldAlert(for: viewController,
                                   buttonLabelText: nameLabel,
                                   updateNamesToDatabase: updateNamesToDatabase,
                                   newTitle: updateLastNameTitle,
                                   newMessage: updateLastNameMessage)
    }
    
    static func showResetEmailAlert(for viewController: UIViewController,
                                    updateNamesToDatabase: @escaping (_ newName: String) -> Void) {
        
        implementTextFieldAlert(for: viewController, updateNamesToDatabase: updateNamesToDatabase,
                                   newTitle: resetEmailTitle, newMessage: resetEmailMessage)
    }
    
    static func showUserSuccessAlertExtension(for viewController: UIViewController,
                                              forAnswer isCorrectAnswer: Bool,
                                              title: String,
                                              message: String,
                                              action: @escaping ((UIAlertAction) -> Void)) {
        
        let actions = UIAlertAction(title: "OK",
                                    style: .default,
                                    handler: action)
        
        setupProfileIntoDatabase(for: viewController,
                                    forAction: actions,
                                    title: title,
                                    message: message)
    }
    
    private static func implementTextFieldAlert(for viewController: UIViewController,
                                                buttonLabelText nameLabel: UIButton? = nil,
                                                updateNamesToDatabase: @escaping (_ newName: String) -> Void,
                                                newTitle title: String,
                                                newMessage message: String) {
        
        var textField = UITextField()
        let actions = UIAlertAction(title: "Change", style: .default, handler: { (_) in
            guard let newFirstName = textField.text else { return }
            nameLabel?.setTitle(newFirstName, for: .normal)
            updateNamesToDatabase(newFirstName)
        })
        
        let newTextField: ((UITextField) -> Void) = { textFields in
            textFields.placeholder = "New Name"
            textField = textFields
        }
        
        setupProfileIntoDatabase(for: viewController,
                                    forAction: actions,
                                    addTextField: newTextField,
                                    buttonLabelText: nameLabel,
                                    title: title,
                                    message: message)
    }
    
    private static func setupProfileIntoDatabase(for viewController: UIViewController,
                                                 forAction action: UIAlertAction,
                                                 addTextField configurationHandlers: ((UITextField) -> Void)? = nil,
                                                 buttonLabelText nameLabel: UIButton? = nil,
                                                 title newTitle: String,
                                                 message newMessage: String) {
        
        let alert = UIAlertController(title: newTitle,
                                      message: newMessage,
                                      preferredStyle: .alert)
        configurationHandlers != nil ? alert.addTextField(configurationHandler: configurationHandlers) : 
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
}
