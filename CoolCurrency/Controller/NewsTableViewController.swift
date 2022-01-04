//
//  NewsTableViewController.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2022/01/04.
//

import UIKit
import NewsAPISwift
import SafariServices

class NewsTableViewController: UITableViewController {

    private let newsAPI = NewsAPI(apiKey: "2f6fc28af88f4ad0955e7e4568e26c37")
    lazy private var newsArticleViewModel = [NewsArticle]()
    lazy private var article = [Article]()
    private var initialErrorMessage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "NewsCell")
        newsAPI.getTopHeadlines(q: "Dollar") { [weak self] result in
            switch result {
            case .success(let headlines):
                if headlines.isEmpty {
                    DispatchQueue.main.async {
                        self!.errorMessage = NSLocalizedString("CURRENT_NEWS_NO_SUBJECT", comment: "") + "Currency"
                        Alerts.showUserNewsOutOfRangeMessageDidInitiate(for: self!, self!.errorMessage)
                    }
                } else {
                    self?.newsArticleViewModel = headlines
                    self?.article = headlines.compactMap({
                        Article(
                            newsList: NewsArray(title: $0.title,
                                               subtile: $0.articleDescription ?? NSLocalizedString("NO_DESCRIPTION", comment: ""),
                                               imageURL: $0.urlToImage)
                        )
                    })
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self!.errorMessage =  NSLocalizedString("NEWS_API_ERROR", comment: "") + "\(error)"
                    Alerts.showUserNewsOutOfRangeMessageDidInitiate(for: self!, self!.errorMessage)
                }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return article.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsTableViewCell
        cell?.configure(with: article[indexPath.row])
        
        return cell ?? NewsTableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = newsArticleViewModel[indexPath.row]
        let vcc = SFSafariViewController(url: article.url)
        
        present(vcc, animated: true, completion: nil)
    }
}

extension NewsTableViewController {
    var errorMessage: String {
        get {
            return initialErrorMessage
        }
        set {
            initialErrorMessage = newValue
        }
    }
}
