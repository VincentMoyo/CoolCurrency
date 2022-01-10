//
//  Article.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2022/01/04.
//

import Foundation

class Article {
    let title: String
    let subtile: String
    let imageURL: URL?
    
    init(
        newsList: NewsArray
    ) {
        self.title = newsList.title
        self.subtile = newsList.subtile
        self.imageURL = newsList.imageURL
    }
}

struct NewsArray {
    let title: String
    let subtile: String
    let imageURL: URL?
}
