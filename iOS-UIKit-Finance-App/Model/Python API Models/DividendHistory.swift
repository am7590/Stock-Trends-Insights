//
//  DividendHistory.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/26/22.
//

import Foundation

//struct DividendHistory: Codable  {
//    let history: [HistoryItem]
//}

struct DividendHistory: Codable {
    let epsEstimate: String
    let epsActual: String
    let difference: String
    let surprise: String
    
    enum CodingKeys: String, CodingKey {
        case epsEstimate = "0"
        case epsActual = "1"
        case difference = "2"
        case surprise = "3"
    }
}
