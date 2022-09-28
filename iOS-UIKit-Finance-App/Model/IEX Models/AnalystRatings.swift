//
//  AnalystRatings.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 8/23/22.
//

import Foundation

// TODO: change name to price target
struct AnalystRatings: Codable, Identifiable {
    let id: String?
    let key: String?
    let subkey: String?
    let symbol: String?
    let analystCount: Int?
    let consensusDate: String?
    let marketConsensus: Double?
    let marketConsensusTargetPrice: Double?
    
    var truncatedConsensusPrice: String? {
        guard let consensus = self.marketConsensus else { return nil }
        
        var trimmedString = String(consensus)
        if let dotRange = trimmedString.range(of: ".") {
            trimmedString.removeSubrange(dotRange.lowerBound..<trimmedString.index(trimmedString.endIndex, offsetBy: -3))
        }
        return trimmedString
            
//        print("xyz \(consensus)")
//        print("xyz \(consensus.truncate(places: 2))")
//        return consensus.truncate(places: 2)
    }
    
    var isBullish: Bool {
        guard let conesus = marketConsensus else { return false }
        return conesus < 50.0 ? true : false
    }
    //let date: Int64
    //let updated: Int64
}
