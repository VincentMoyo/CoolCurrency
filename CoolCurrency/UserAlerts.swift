//
//  UserAlerts.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/11/16.
//

import Foundation
import UIKit

struct Alerts {
    
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
    
    static func setupProfileIntoDatabase(for viewController: UIViewController,
                                         buttonLabelText nameLabel: UIButton? = nil,
                                         updateNamesToDatabase: @escaping (_ newName: String) -> Void) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Set Name",
                                      message: "Set your username to complete your profile account setup",
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
