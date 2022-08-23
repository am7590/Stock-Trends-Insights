//
//  AnalystRatings.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 8/23/22.
//

import Foundation

// TODO: Add analyst data from Refintiv
// Current data is more of a price target (from doc.)
struct AnalystRatings: Codable, Identifiable {
    let id: String?
    let key: String?
    let subkey: String?
    let symbol: String?
    let analystCount: Int?
    let consensusDate: String?
    let marketConsensus: Double?
    let marketConsensusTargetPrice: Double?
    //let date: Int64
    //let updated: Int64
}
