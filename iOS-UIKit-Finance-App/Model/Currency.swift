//
//  Currency.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/25/22.
//

import Foundation

/// {"currency":"EUR","yesterday":"1.03140","today":"1.030227"}

struct Currency: Codable, Hashable {
    public let currency: String
    public let priceYesterday: String
    public let priceToday: String
    
    enum CodingKeys: String, CodingKey {
        case currency
        case priceYesterday = "yesterday"
        case priceToday = "today"
    }
    
    public var currencyIsPositive: Bool {
        return priceToday.prefix(1) == "-" ? false : true
    }
    
    /// Returns in a tuple (price difference, % difference,  if the difference is positive or negative)
    public var difference: (Double?, Double?, Bool?) {
        var todayPrice: Double?
        var yesterdayPrice: Double?
        var difference: Double?
                
        // This will be refactored when I have more reliable currency exchange data
        // IEX's endpoint is broken so I'm using a crappy free service
        if let today = Double(priceToday) {
            todayPrice = today
        } else if let today = Double(priceToday.dropLast()) {
            todayPrice = today
        } else {
            return (nil, nil, nil)
        }
        
        if let yesterday = Double(priceYesterday) {
            yesterdayPrice = yesterday
        } else if let yesterday = Double(priceYesterday.dropLast()) {
            yesterdayPrice = yesterday
        } else {
            return (nil, nil, nil)
        }
        
        guard let todayPrice = todayPrice, let yesterdayPrice = yesterdayPrice else { return (nil, nil, nil) }
        difference = yesterdayPrice-todayPrice
        return (difference,(difference!/todayPrice)*100.truncate(places: 4), difference!.sign == .minus ? true : false)
    }
    
    public var truncatedPriceToday: String {
        return String(priceToday.prefix(5))
    }
}


extension Double {
    func truncate(places : Int) -> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
