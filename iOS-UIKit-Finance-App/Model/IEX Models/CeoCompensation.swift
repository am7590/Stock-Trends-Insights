//
//  CeoCompensation.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 8/23/22.
//

import Foundation

struct CeoCompensation: Codable {
    let symbol: String?
    let name: String?
    let companyName: String?
    let location: String?
    let salary: Int?
    let bonus: Int?
    let stockAwards: Int?
    let optionAwards: Int?
    let nonEquityIncentives: Int?
    let pensionAndDeferred: Int?
    let otherComp: Int?
    let total: Int?
    let year: String?
}
