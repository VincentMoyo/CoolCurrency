//
//  CryptoAndMetalsRepository.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/11/10.
//

import Foundation

struct CryptoAndMetalsRepository {
    
<<<<<<< HEAD
=======
    func performBitcoinValueRequest(for baseCurrency: String, completion: @escaping BitcoinDataResponseModel) {
        if let url = URLBitcoinStringBuilder(for: baseCurrency) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, _, error) in
                if error != nil {
                    completion(.failure((error!)))
                    return
                }
                do {
                    let decodedData = try JSONDecoder().decode(CoinData.self, from: data!)
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
    
    func performMetalsValueRequest(for baseCurrency: String, completion: @escaping MetalsDataResponseModel) {
        if let url = URLMetalsStringBuilder(for: baseCurrency) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, _, error) in
                if error != nil {
                    completion(.failure((error!)))
                    return
                }
                do {
                    let decodedData = try JSONDecoder().decode(MetalsResponseModel.self, from: data!)
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
    
    private func URLBitcoinStringBuilder(for baseCurrency: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.BitcoinAPI.URLBuilder.kScheme
        urlComponents.host = Constants.BitcoinAPI.URLBuilder.kHost
        urlComponents.path = Constants.BitcoinAPI.URLBuilder.kPath + baseCurrency
        let apiKeyQueryItem = URLQueryItem(name: Constants.BitcoinAPI.URLBuilder.kAPIKeyString,
                                           value: Constants.BitcoinAPI.URLBuilder.kAPIKey)
        urlComponents.queryItems = [apiKeyQueryItem]
        return urlComponents.url
    }
    
    private func URLMetalsStringBuilder(for baseCurrency: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.MetalAPI.URLBuilder.kScheme
        urlComponents.host = Constants.MetalAPI.URLBuilder.kHost
        urlComponents.path = Constants.MetalAPI.URLBuilder.kPath
        let apiKeyQueryItem = URLQueryItem(name: Constants.MetalAPI.URLBuilder.kAPIKeyString,
                                           value: Constants.MetalAPI.URLBuilder.kAPIKey)
        let currencyBaseQueryItem = URLQueryItem(name: Constants.MetalAPI.URLBuilder.kBaseString,
                                                 value: baseCurrency)
        urlComponents.queryItems = [apiKeyQueryItem, currencyBaseQueryItem]
        return urlComponents.url
    }
>>>>>>> Development
}
