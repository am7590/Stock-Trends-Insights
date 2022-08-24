//
//  News.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 8/23/22.
//

import Foundation

/**
 [
    "AAPL",
    "Aug-18-22",
    "02:33PM",
    "Fox, CBS, and NBC are splitting historic $7 billion Big Ten sports deal",
    "Yahoo Finance",
    "https://finance.yahoo.com/news/fox-cbs-and-nbc-are-splitting-historic-7-billion-big-ten-sports-deal-183347229.html"
 ]
  */

struct News: Codable {
    // let datetime: Int64?
    let headline: String?
    let source: String?
    let url: String?
    let summary: String?
    let related: String?
    let image: String?
    let lang: String?
    let hasPaywall: Bool?
}
