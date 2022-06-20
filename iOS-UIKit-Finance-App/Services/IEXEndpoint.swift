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
        }
    }
}
