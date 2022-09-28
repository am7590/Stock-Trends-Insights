//
//  Sentiment.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/15/22.
//

import Foundation
import UIKit

/// "{\"ticker\": \"aapl\", \"socialMedia\": \"reddit\", \"sentimentScore\": 4.9, \"itemsScanned\": 825}"
struct Sentiment: Codable {
    let ticker: String
    let socialMedia: String
    let sentimentScore: Double
    let itemsScanned: Int
    
    var png: UIImage {
        switch socialMedia {
        case "Twitter":
            return UIImage(named: "twitter")!
        case "Reddit":
            return UIImage(named: "reddit")!
        case "Facebook":
            return UIImage(named: "facebook")!
        case "Stocktwits":
            return UIImage(named: "stocktwits")!
        default:
            return UIImage(named: "")!
        }
    }
}
