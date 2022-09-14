//
//  Stats.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 8/23/22.
//

import Foundation

struct Stats: Codable {
    let beta: Double?
    let totalCash: Int?
    let currentDebt: Int?
    let revenue: Int?
    let grossProfit: Int?
    let totalRevenue: Int?
    let EBITDA: Int?
    let revenuePerShare: Double?
    let revenuePerEmployee: Double?
    let debtToEquity: Double?
    let profitMargin: Double?
    let enterpriseValue: Int?
    let enterpriseValueToRevenue: Double?
    let priceToSales: Double?
    let priceToBook: Double?
    let forwardPERatio: Double?
    let pegRatio: Double?
    let peHigh: Double?
    let peLow: Double?
    let week52highDate: String?
    let week52lowDate: String?
    let putCallRatio: Double?
    let companyName: String?
    let marketcap: Int?
    let week52high: Double?
    let week52low: Double?
    let week52highSplitAdjustOnly: Double?
    let week52highDateSplitAdjustOnly: String?
    let week52lowSplitAdjustOnly: Double?
    let week52lowDateSplitAdjustOnly: String?
    let week52change: Double?
    let sharesOutstanding: Int?
    let avg10Volume: Int?
    let avg30Volume: Int?
    let day200MovingAvg: Double?
    let day50MovingAvg: Double?
    let employees: Int?
    let ttmEPS: Double?
    let ttmDividendRate: Double?
    let dividendYield: Double?
    let nextDividendDate: String?
    let exDividendDate: String?
    let nextEarningsDate: String?
    let peRatio: Double?
    let maxChangePercent: Double?
    let year5ChangePercent: Double?
    let year2ChangePercent: Double?
    let year1ChangePercent: Double?
    let month3ChangePercent: Double?
    let month1ChangePercent: Double?
    let day30ChangePercent: Double?
    let day5ChangePercent: Double?
}
