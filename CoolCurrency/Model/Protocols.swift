//
//  Protocols.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/05.
//

import Foundation

protocol ErrorReporting: AnyObject {
    func showUserErrorMessageDidInitiate(_ message: String)
}
