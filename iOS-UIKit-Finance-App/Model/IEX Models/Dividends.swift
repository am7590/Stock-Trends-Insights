//
//  Dividends.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 8/23/22.
//

import Foundation

public struct Dividends: Codable {
    public let amount: Double
    public let currency: String
    public let declaredDate: String
    public let description: String
    public let exDate: String
    public let flag: String
    public let frequency: String
    public let paymentDate: String
    public let recordDate: String
    public let refid: Int
    public let symbol: String
    public let id: String
    public let key: String?
    public let subkey: String?
    // let date: Int64?
    public let updated: Double?
}
