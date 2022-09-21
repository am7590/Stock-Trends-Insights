//
//  NewsTableViewCell.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 7/19/22.
//

import UIKit
import SwiftUI

class NewsTableViewCell: UITableViewCell {
    
    // let viewModel: ViewModel? = nil
    
    var cellSubView = UIHostingController(rootView: NewsCellSubView(newsItem: NewsItem(datetime: 0, headline: "", source: "", url: "", summary: "", image: "", hasPaywall: false)))
    let balanceStackView = UIStackView()
    
    static let reuseID = "NewsTableViewCell"
    static let rowHeight: CGFloat = 112
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with newsItem: NewsItem) {
        cellSubView = UIHostingController(rootView: NewsCellSubView(newsItem: newsItem))
    }
    
    private func setup() {
        cellSubView.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cellSubView.view)
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            cellSubView.view.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            cellSubView.view.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            cellSubView.view.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cellSubView.view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
     }
}
