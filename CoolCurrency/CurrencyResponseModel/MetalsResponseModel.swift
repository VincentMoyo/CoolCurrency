//
//  MetalsResponseModel.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/21.
//

import Foundation

struct MetalsResponseModel: Codable {
    let rates: MetalRates
}

struct MetalRates: Codable {
    let gold: Double
    let platinum: Double
    let silver: Double
    
    private enum CodingKeys: String, CodingKey {
        case gold = "XAU"
        case platinum = "XPT"
        case silver = "XAG"
    }
}
