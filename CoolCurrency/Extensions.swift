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
}

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
