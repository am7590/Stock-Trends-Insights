//
//  APIParser.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 5/22/22.
//

import Foundation

class APIParser {

    var newsComponent = URLComponents(string: "https://finviz-news-sentiment-analysis-non-redis-api.apps.okd4.csh.rit.edu/news/")
    var sentimentComponent = URLComponents(string: "https://finviz-news-sentiment-analysis-non-redis-api.apps.okd4.csh.rit.edu/sentiment/")
    var welcomeComponent = URLComponents(string: "https://finviz-news-sentiment-analysis-non-redis-api.apps.okd4.csh.rit.edu/welcome/")

    func getNewsRequest(ticker : String) -> URLComponents {
        newsComponent?.queryItems = [
            URLQueryItem(name: "ticker", value: ticker),
        ]
        
        return newsComponent!
    }
    
    func getSentimentRequest(ticker : String) -> URLComponents {
        sentimentComponent?.queryItems = [
            URLQueryItem(name: "ticker", value: ticker),
        ]
        
        return sentimentComponent!
    }
    
    func getWelcomeRequest(date : String) -> URLComponents {
        sentimentComponent?.queryItems = [
            URLQueryItem(name: "date", value: date),
        ]
        
        return sentimentComponent!
    }
}
