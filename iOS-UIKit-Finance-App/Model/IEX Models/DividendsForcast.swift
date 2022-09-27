//
//  DividendsForcast.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 8/23/22.
//

import Foundation

struct DividendsForcast: Codable, Identifiable {
    let adjustedAmount: Double?
    let amount: Double?
    let currency: String?
    let declaredDate: String?
    let disbursementAmount: Double?
    let disbursementType: String?
    let exDate: String?
    let fiscalYear: Int?
    // fiscalYearEndDate
    let frequency: String?
    // fxDate
    let lastChange: String?
    let marker: String?
    let name: String?
    // nonTaxedAmount
    let paymentDate: String
    // periodEndDate
    let position: Int?
    let recordDate: String?
    let recordUpdated: String?
    let sharesHeld: Int?
    let sharesReceived: Int?
    let status: String?
    let symbol: String?
    let id: String?
    let key: String?
    let subkey: String?
    // let date: Int64?
    let updated: Double?
}
