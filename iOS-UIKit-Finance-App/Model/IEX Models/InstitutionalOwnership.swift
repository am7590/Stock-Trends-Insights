//
//  InstitutionalOwnership.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 8/23/22.
//

import Foundation

struct InstitutionalOwnership: Codable {
    let symbol: String?
    let id: String?
    let adjHolding: Int?
    let adjMv: Int?
    let entityProperName: String?
    let reportDate: Int?
    let filingDate: String?
    let reportedHolding: Int?
    // let date: Int64?
    // let updated: Int64?
}
