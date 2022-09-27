//
//  Analyst.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/26/22.
//

import Foundation

/**
 [{"recommendationTrend":
    {"trend":
        [{"period":"0m","strongBuy":4,"buy":4,"hold":8,"sell":6,"strongSell":1},
         {"period":"-1m","strongBuy":12,"buy":14,"hold":10,"sell":5,"strongSell":3},
         {"period":"-2m","strongBuy":11,"buy":15,"hold":10,"sell":6,"strongSell":3},
         {"period":"-3m","strongBuy":4,"buy":4,"hold":8,"sell":6,"strongSell":0}],
    "maxAge":86400 }}]
 */

struct Analyst: Codable {
    let recommendationTrend: TrendList
}

struct TrendList: Codable {
    let trend: [Trend]
    let maxAge: Int
}

struct Trend: Codable {
    let period: String
    let strongBuy: Int
    let buy: Int
    let hold: Int
    let sell: Int
    let strongSell: Int
}
