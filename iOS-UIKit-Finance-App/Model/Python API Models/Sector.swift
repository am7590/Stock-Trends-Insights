//
//  Sector.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/24/22.
//

import Foundation

/**
 [{"type":"sector","name":"Health Care","symbol":"XLV","performance":-0.00511,"lastUpdated":1663963200060},
 staroflife.circle
 {"type":"sector","name":"Utilities","symbol":"XLU","performance":-0.01157,"lastUpdated":1663963200078},
 fuelpump.fill
 {"type":"sector","name":"RealEstate","symbol":"XLRE","performance":-0.01239,"lastUpdated":1663963200132},
 house
 {"type":"sector","name":"Technology","symbol":"XLK","performance":-0.01308,"lastUpdated":1663963200005},
 sparkles.tv
 {"type":"sector","name":"Financials","symbol":"XLF","performance":-0.01585,"lastUpdated":1663963200068},
 dollarsign.square
 {"type":"sector","name":"ConsumerStaples","symbol":"XLP","performance":-0.017,"lastUpdated":1663963200004},
 cart
 {"type":"sector","name":"Industrials","symbol":"XLI","performance":-0.01876,"lastUpdated":1663963200065},
 doc.badge.gearshape.fill
 {"type":"sector","name":"CommunicationServices","symbol":"XLC","performance":-0.01937,"lastUpdated":1663963200138},
 iphone.radiowaves.left.and.right
 {"type":"sector","name":"Materials","symbol":"XLB","performance":-0.02047,"lastUpdated":1663963200004},
 wrench.and.screwdriver
 {"type":"sector","name":"ConsumerDiscretionary","symbol":"XLY","performance":-0.02302,"lastUpdated":1663963200003},
 car.2
 {"type":"sector","name":"Energy","symbol":"XLE","performance":-0.06896,"lastUpdated":1663963200056}]
 powerplug */

struct Sector: Codable, Hashable {
    let name: String
    let symbol: String
    let performance: Double
    let lastUpdated: Date
}

extension Sector {
    var icon: String {
        switch self.symbol {
        case "XLV":
            return "staroflife.fill"
        case "XLU":
            return "fuelpump.fill"
        case "XLRE":
            return "house"
        case "XLK":
            return "sparkles.tv"
        case "XLF":
            return "dollarsign.square"
        case "XLP":
            return "cart"
        case "XLI":
            return "doc.badge.gearshape.fill"
        case "XLC":
            return "iphone.radiowaves.left.and.right"
        case "Materials":
            return "wrench.and.screwdriver"
        case "XLB":
            return "car.2"
        case "XLY":
            return "ipad.and.iphone"
        case "XLE":
            return "powerplug"
        default:
            return "newspaper"
        }
    }
    
    var performanceIsPositive: Bool {
        return performance.sign == .minus ? false : true
    }
}
