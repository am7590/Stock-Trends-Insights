//
//  NewsViewModel.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/20/22.
//

import Foundation

@MainActor class NewsViewModel: StockAppViewModel {
    let ticker: String
    var news: NewsItem?
    
    @Published var state: State = .loading
    
    init(ticker: String, news: NewsItem) {
        self.ticker = ticker
        self.news = news
    }
}
