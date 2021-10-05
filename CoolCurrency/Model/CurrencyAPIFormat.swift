//
//  CurrencyAPIFormat.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/05.
//

import Foundation

struct CurrencyAPIFormat: Codable {
    
    let response: Response
    
    struct Response: Codable {
        let base: String
        let rates: Rates
        
        struct Rates: Codable {
            let USD: Double
            let EUR: Double
            let INR: Double
            let BWP: Double
            let CAD: Double
            let GHS: Double
            let GBP: Double
            let JPY: Double
            let RUB: Double
            let CNY: Double
            let ZAR: Double
        }
    }
}
