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
    
    static func showUserNotificationDidInitiate(for viewController: UIViewController, _ message: String) {
        
        let alertController = UIAlertController(title: NSLocalizedString("ERROR", comment: ""),
                                                message: message,
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""),
                                                style: .default,
                                                handler: nil))
        
        viewController.present(alertController, animated: true)
    }
    
    static func showUpdateFirstNameAlert(for viewController: UIViewController,
                                         buttonLabelText nameLabel: UIButton? = nil,
                                         updateNamesToDatabase: @escaping (_ newName: String) -> Void) {
        
        implementTextFieldForAlert(for: viewController,
                                      buttonLabelText: nameLabel,
                                      updateNamesToDatabase: updateNamesToDatabase,
                                      newTitle: updateFirstNameTitle,
                                      newMessage: updateFirstNameMessage)
    }
    
    static func showUpdateLastNameAlert(for viewController: UIViewController,
                                        buttonLabelText nameLabel: UIButton? = nil,
                                        updateNamesToDatabase: @escaping (_ newName: String) -> Void) {
        
        implementTextFieldForAlert(for: viewController,
                                      buttonLabelText: nameLabel,
                                      updateNamesToDatabase: updateNamesToDatabase,
                                      newTitle: updateLastNameTitle,
                                      newMessage: updateLastNameMessage)
    }
    
    static func showResetEmailAlert(for viewController: UIViewController,
                                    updateNamesToDatabase: @escaping (_ newName: String) -> Void) {
        
        implementTextFieldForAlert(for: viewController, updateNamesToDatabase: updateNamesToDatabase,
                                      newTitle: resetEmailTitle, newMessage: resetEmailMessage)
    }
    
    static func showUserSuccessAlertExtension(for viewController: UIViewController,
                                              forAnswer isCorrectAnswer: Bool,
                                              title: String,
                                              message: String,
                                              action: @escaping ((UIAlertAction) -> Void)) {
        
        showUserAlert(for: viewController,
                         forAction: action,
                         title: title,
                         message: message)
    }
    
    private static func showUserAlert(for viewController: UIViewController,
                                      forAction action: @escaping ((UIAlertAction) -> Void),
                                      addTextField configurationHandlers: ((UITextField) -> Void)? = nil,
                                      buttonLabelText nameLabel: UIButton? = nil,
                                      title newTitle: String,
                                      message newMessage: String) {
        
        let alert = UIAlertController(title: newTitle,
                                      message: newMessage,
                                      preferredStyle: .alert)
        let actions = UIAlertAction(title: "OK",
                                    style: .default,
                                    handler: action)
        
        if configurationHandlers != nil {
            alert.addTextField(configurationHandler: configurationHandlers)
            alert.addAction(actions)
        } else {
            alert.addAction(actions)
        }
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    private static func implementTextFieldForAlert(for viewController: UIViewController,
                                                   buttonLabelText nameLabel: UIButton? = nil,
                                                   updateNamesToDatabase: @escaping (_ newName: String) -> Void,
                                                   newTitle title: String,
                                                   newMessage message: String) {
        
        var textField = UITextField()
        let actionWithTextfield: ((UIAlertAction) -> Void) = { (_) in
            guard let newFirstName = textField.text else { return }
            nameLabel?.setTitle(newFirstName, for: .normal)
            updateNamesToDatabase(newFirstName)
        }
        
        let newTextField: ((UITextField) -> Void) = { textFields in
            textFields.placeholder = "Set New"
            textField = textFields
        }
        
        showUserAlert(for: viewController,
                         forAction: actionWithTextfield,
                         addTextField: newTextField,
                         buttonLabelText: nameLabel,
                         title: title,
                         message: message)
    }
}
