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
    // let datetime: Int64?
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
    let subkey: String?
    // let date: Int64?
    let updated: Double?
}

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
    let paymentDate: String?
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

// TODO: Add analyst data from Refintiv
// Current data is more of a price target (from doc.)
struct AnalystRatings: Codable, Identifiable {
    let id: String?
    let key: String?
    let subkey: String?
    let symbol: String?
    let analystCount: Int?
    let consensusDate: String?
    let marketConsensus: Double?
    let marketConsensusTargetPrice: Double?
    //let date: Int64
    //let updated: Int64
}
