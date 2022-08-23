//
//  InsiderTransactions.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 8/23/22.
//

import Foundation

struct InsiderTransactions: Codable {
    let conversionOrExercisePrice: Double?
    let directIndirect: String?
    // let effectiveDate: Int64?
    let filingDate: String?
    let fullName: String?
    let is10b51: Bool?
    let postShares: Int?
    let reportedTitle: String?
    let symbol: String?
    let transactionCode: String?
    let transactionDate: String?
    let transactionPrice: Double?
    let transactionShares: Int?
    let transactionValue: Int?
    let id: String?
    let key: String?
    let subkey: String?
    // let date: Int64
    let updated: Double?
    let tranPrice: Double?
    let tranShares: Double?
    let tranValue: Int?
}
