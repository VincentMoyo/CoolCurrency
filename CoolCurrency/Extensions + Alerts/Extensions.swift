//
//  Extensions.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/08.
//

import Foundation
import UIKit

// MARK: - View Controller extensions
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

// MARK: - Double extensions
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

// MARK: - Array extensions
extension Array {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

// MARK: - UIColour extenstions
extension UIColor {
    static var primaryColour: UIColor? {
        UIColor(named: "PrimaryColour")
    }
    
    static var secondaryColour: UIColor? {
        UIColor(named: "SecondaryColour")
    }
    
    static var tertiaryColour: UIColor? {
        UIColor(named: "TertiaryColour")
    }
    
    static var quaternaryColour: UIColor? {
        UIColor(named: "OldBrown")
    }
}

// MARK: - UIFont extenstions
extension UIFont {
    static var titleFont: UIFont {
        UIFont.systemFont(ofSize: 50, weight: .medium)
    }
    
    static var firstHeading: UIFont {
        UIFont.systemFont(ofSize: 30)
    }
    
    static var secondHeading: UIFont {
        UIFont.systemFont(ofSize: 20)
    }
    
    static var boldHeading: UIFont {
        UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    static var largeText: UIFont {
        UIFont.systemFont(ofSize: 15)
    }
    
    static var smallText: UIFont {
        UIFont.systemFont(ofSize: 13)
    }
}
