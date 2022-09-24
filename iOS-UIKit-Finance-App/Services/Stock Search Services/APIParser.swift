//
//  APIParser.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 5/22/22.
//

import Foundation

class APIParser {

    var newsComponent = URLComponents(string: "http://127.0.0.1:4200/news/")
    var sentimentComponent = URLComponents(string: "http://127.0.0.1:4200/sentiment/")
    var welcomeComponent = URLComponents(string: "http://127.0.0.1:4200/welcome/")

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
