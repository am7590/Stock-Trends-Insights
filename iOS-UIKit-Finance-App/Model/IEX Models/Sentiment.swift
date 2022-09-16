//
//  Sentiment.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/15/22.
//

import Foundation

/// "{\"ticker\": \"aapl\", \"socialMedia\": \"reddit\", \"sentimentScore\": 4.9, \"itemsScanned\": 825}"
struct Sentiment: Codable {
    let ticker: String
    let socialMedia: String
    let sentimentScore: Double
    let itemsScanned: Int
}
