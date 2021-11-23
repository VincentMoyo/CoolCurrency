//
//  CurrencyRepository.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/05.
//

import Foundation

class CurrencyRepository: CurrencyRepositable {
    
    func performCurrencyRequest(for baseCurrency: String, completion: @escaping ListCurrencyResponseModel) {
        if let url = URLCurrencyStringBuilder(for: baseCurrency) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, _, error) in
                if error != nil {
                    completion(.failure((error!)))
                    return
                }
                do {
                    let decodedData = try JSONDecoder().decode(CurrencyResponseModel.self, from: data!)
                    DispatchQueue.main.async {
                        completion(.success(decodedData))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
    }
    
    private func URLCurrencyStringBuilder(for baseCurrency: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.CurrencyAPI.URLBuilder.kScheme
        urlComponents.host = Constants.CurrencyAPI.URLBuilder.kHost
        urlComponents.path = Constants.CurrencyAPI.URLBuilder.kPath
        let apiKeyQueryItem = URLQueryItem(name: Constants.CurrencyAPI.URLBuilder.kAPIKeyString, value: Constants.CurrencyAPI.URLBuilder.kAPIKey)
        let currencyBaseQueryItem = URLQueryItem(name: Constants.CurrencyAPI.URLBuilder.kBaseString, value: baseCurrency)
        urlComponents.queryItems = [apiKeyQueryItem, currencyBaseQueryItem]
        return urlComponents.url
    }
}
