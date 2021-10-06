//
//  CurrencyRepository.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/05.
//

import Foundation

struct CurrencyRepository: CurrencyRepositable {
    
    func performCurrencyRequest(for baseCurrency: String, completion: @escaping (Result<CurrencyResponseModel, Error>) -> Void) {
        if let url = URLCurrencyStringBuilder(for: baseCurrency) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, _, error) in
                if error != nil {
                    completion(.failure((error!)))
                    return
                }
                do {
                    let decodedData = try JSONDecoder().decode(CurrencyResponseModel.self, from: data!)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    private func URLCurrencyStringBuilder(for baseCurrency: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.URLBuilder.kScheme
        urlComponents.host = Constants.URLBuilder.kHost
        urlComponents.path = Constants.URLBuilder.kPath
        let apiKeyQueryItem = URLQueryItem(name: Constants.URLBuilder.kAPIKeyString, value: Constants.URLBuilder.kAPIKey)
        let currencyBaseQueryItem = URLQueryItem(name: Constants.URLBuilder.kBaseString, value: baseCurrency)
        urlComponents.queryItems = [apiKeyQueryItem, currencyBaseQueryItem]
        return urlComponents.url
    }
}
