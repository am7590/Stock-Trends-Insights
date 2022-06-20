//
//  IEXModels.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/20/22.
//

import Foundation

struct Logo: Codable {
    let url: URL?
}

struct CompanyInfo: Codable {
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

struct News: Codable {
    let datetime: Int?
    let headline: String?
    let source: String?
    let url: String?
    let summary: String?
    let related: String?
    let image: String?
    let lang: String?
    let hasPaywall: Bool?
}

struct Dividends: Codable {
    let amount: Double?
    let currency: String?
    let declaredDate: String?
    let description: String?
    let exDate: String?
    let flag: String?
    let frequency: String?
    let paymentDate: String?
    let recordDate: String?
    let refid: Int?
    let symbol: String?
    let id: String?
    let key: String?
    let subkey: Int?
    let date: Int64?
    let updated: Double?
}
