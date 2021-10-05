//
//  CurrencyRequest.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/05.
//

import Foundation

struct CurrencyRequest {
    
    var delegateError: ErrorReporting?
    
    func performCurrencyRequest(for baseCurrency: String, completion: @escaping (Result<CurrencyDataModel, Error>) -> Void) {
        if let url = URLCurrencyStringBuilder(for: baseCurrency) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, _, error) in
                if error != nil {
                    completion(.failure((error!)))
                    return
                }
                if let wrappedData = data {
                    if let currency = self.parseCurrencyJSON(for: wrappedData) {
                        completion(.success(currency))
                    }
                }
            }
            task.resume()
        }
    }
    
    private func URLCurrencyStringBuilder(for baseCurrency: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.currencyscoop.com"
        urlComponents.path = "/v1/latest"
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: Constants.kAPIKey)
        let currencyBaseQueryItem = URLQueryItem(name: "base", value: baseCurrency)
        urlComponents.queryItems = [apiKeyQueryItem, currencyBaseQueryItem]
        return urlComponents.url
    }
    
    private func parseCurrencyJSON(for currencyData: Data) -> CurrencyDataModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CurrencyAPIFormat.self, from: currencyData)
            
            return CurrencyDataModel(baseCurrency: decodedData.response.base,
                                     greatBritishPound: decodedData.response.rates.GBP,
                                     unitedStatesDollar: decodedData.response.rates.USD,
                                     indianRupee: decodedData.response.rates.INR,
                                     bostwanaPula: decodedData.response.rates.BWP,
                                     canadianDollar: decodedData.response.rates.CAD,
                                     ghanaCedi: decodedData.response.rates.GHS,
                                     southAfricanRand: decodedData.response.rates.ZAR,
                                     japaneseYen: decodedData.response.rates.JPY,
                                     russianRuble: decodedData.response.rates.RUB,
                                     chineseYuan: decodedData.response.rates.CNY,
                                     euro: decodedData.response.rates.EUR)
            
        } catch {
            delegateError?.showUserErrorMessageDidInitiate("Error")
            return nil
        }
    }
}
