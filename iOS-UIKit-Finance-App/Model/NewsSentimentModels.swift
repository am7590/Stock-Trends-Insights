//
//  NewsSentimentModels.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/20/22.
//

import Foundation

struct NewsStruct: Decodable {
    var ticker: String
    var content: [[String]]
    var time_called: String
}

struct SentimentStruct: Decodable {
    var ticker: String
    var content: [String:Double]
    var time_called: String
}
