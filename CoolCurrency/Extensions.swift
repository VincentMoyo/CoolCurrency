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

extension UIColor {
    public convenience init?(hex: String) {
        let red, green, blue, alpha: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    red = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    green = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    blue = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    alpha = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: red, green: green, blue: blue, alpha: alpha)
                    return
                }
            }
        }

        return nil
    }
}
