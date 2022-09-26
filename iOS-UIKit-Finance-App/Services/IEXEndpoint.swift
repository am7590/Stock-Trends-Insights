//
//  IEXEndpoint.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/20/22.
//

import Foundation

enum IEXEndpoint {
    case logo(stock: String)
    case companyInfo(stock: String)
    case stats(stock: String)
    case news(stock: String)
    case dividends(stock: String)
    case institutionalOwnership(stock: String)
    case insiderTransactions(stock: String)
    case ceoCompensation(stock: String)
    case dividendsForcast(stock: String)
    case analystRatings(stock: String)
    case dummyData(stock: String, socialMedia: String)
    case sector
    case currency
}

extension IEXEndpoint: Endpoint {
    var path: String {
        switch self {
        case .logo(let stock):
            return "/logo/\(stock)"
        case .companyInfo(let stock):
            return "/company-info/\(stock)"
        case .stats(stock: let stock):
            return "/stats/\(stock)"
        case .news(stock: let stock):
            return "/news/\(stock)"
        case .dividends(stock: let stock):
            return "/dividends/\(stock)"
        case .institutionalOwnership(stock: let stock):
            return "/institutional-ownership/\(stock)"
        case .insiderTransactions(stock: let stock):
            return "/insider-transactions/\(stock)"
        case .ceoCompensation(stock: let stock):
            return "/ceo-compensation/\(stock)"
        case .dividendsForcast(stock: let stock):
            return "/dividends-forcast/\(stock)"
        case .analystRatings(stock: let stock):
            return "/analyst-ratings/\(stock)"
        case .dummyData(stock: let stock, socialMedia: let socialMedia):
            return "/sentiment/\(stock)/\(socialMedia)"
        case .sector:
            return "/sectors"
        case .currency:
            return "/currency"
        }
    }
}
