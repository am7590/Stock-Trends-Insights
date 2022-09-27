//
//  CompanyInfo.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 8/23/22.
//

import Foundation

public struct CompanyInfo: Codable {
    let symbol: String?
    let companyName: String?
    let exchange: String?
    let industry: String?
    let website: String?
    let description: String?
    let CEO: String?
    let securityName: String?
    let issueType: String?
    let sector: String?
    let employees: Int?
    let tags: [String]?
    let address: String?
    let state: String?
    let city: String?
    // Zip, country, phone
}
