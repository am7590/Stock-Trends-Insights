//
//  AnalystResults.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 5/26/22.
//

import Foundation
  
struct AnalystResult: Decodable {
    let analystCount: Int
    let consensusDate: String
    let marketConsensus: Double
    let marketConsensusTargetPrice: Double
    let symbol: String
    let updated: Double
    
    
    
    // Map JSON values from API to variables with a different name
//    enum CodingKeys: String, CodingKey {
//        case symbol = "1. symbol"
//        case name = "2. name"
//        case type = "3. type"
//        case currency = "8. currency"
//    }
    
}
 
