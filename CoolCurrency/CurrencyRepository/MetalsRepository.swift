//
//  MetalsRepository.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/21.
//

import Foundation

struct MetalsRepository: MetalsRepositable {
    
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
    
    private func URLMetalsStringBuilder(for baseCurrency: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.MetalAPI.URLBuilder.kScheme
        urlComponents.host = Constants.MetalAPI.URLBuilder.kHost
        urlComponents.path = Constants.MetalAPI.URLBuilder.kPath
        let apiKeyQueryItem = URLQueryItem(name: Constants.MetalAPI.URLBuilder.kAPIKeyString, value: Constants.MetalAPI.URLBuilder.kAPIKey)
        let currencyBaseQueryItem = URLQueryItem(name: Constants.MetalAPI.URLBuilder.kBaseString, value: baseCurrency)
        urlComponents.queryItems = [apiKeyQueryItem, currencyBaseQueryItem]
        return urlComponents.url
    }
}
