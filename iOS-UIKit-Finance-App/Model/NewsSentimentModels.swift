//
//  NewsSentimentModels.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/20/22.
//

import Foundation

struct NewsItem: Codable {
    let datetime: Int64
    let headline: String
    let source: String
    let url: String
    let summary: String
    let image: String
    let hasPaywall: Bool
}

struct SentimentStruct: Decodable {
    var content: [String:Double]
    var type: String
}
