//
//  NewsTableViewCell.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2022/01/04.
//

import UIKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {

    @IBOutlet private weak var headingLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with viewModel: Article) {
        headingLabel.text = viewModel.title
        descriptionLabel.text = viewModel.subtile
        newsImage.kf.setImage(with: viewModel.imageURL)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
