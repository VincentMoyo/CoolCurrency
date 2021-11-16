//
//  Extensions.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/08.
//

import Foundation
import UIKit

extension UIViewController {
    func showUserErrorMessage(error: Error) {
        let alertController = UIAlertController(title: NSLocalizedString("ERROR", comment: ""),
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""),
                                                style: .default,
                                                handler: nil))
        present(alertController, animated: true)
    }
}

extension Double {
    func roundedOffCurrency() -> Double {
        let convertedCurrency = 1 / self
        let divisor = pow(10.0, Double(2))
        return (convertedCurrency * divisor).rounded() / divisor
    }
    
    func convertOunceToGramsAndRoundOff() -> Double {
        let convertedCurrency = self / 28.3495
        let divisor = pow(10.0, Double(2))
        return (convertedCurrency * divisor).rounded() / divisor
    }
    
    func roundOff() -> Double {
        let divisor = pow(10.0, Double(2))
        return (self * divisor).rounded() / divisor
    }
}

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension UIAlertController {
    
    class func setupProfileIntoDatabase(for viewController: UIViewController,
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
