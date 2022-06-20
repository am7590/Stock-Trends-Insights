//
//  HomeModels.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 5/30/22.
//

import Foundation

struct URLs {
    static let analystRecommendationsPriceTargets = URL(string: "https://cloud.iexapis.com/stable/time-series/CORE_ESTIMATES/aapl?token=pk_b8d39299974f41f99ef8f79101ab2617")
    static let fetchIntradayPrice = URL(string:"https://cloud.iexapis.com/stable/time-series/CORE_ESTIMATES/aapl?token=pk_b8d39299974f41f99ef8f79101ab2617")
    static let logo = URL(string: "http://127.0.0.1:8000/logo/tsla")
    static let companyInfo = URL(string: "http://127.0.0.1:8000/company-info/tsla")
}

struct AnalystRecommendationsPriceTargets: Codable {
    let id: String
    let key: String
    let subkey: String
    let symbol: String
    let analystCount: Int
    let consensusDate: String
    let marketConsensus: Double
    let marketConsensusTargetPrice: Double
    //let date: Int64
    //let updated: Int64
    
}

struct Logo: Codable {
    let url: URL?
}

struct CompanyInfo: Codable {
    let symbol: String
    let companyName: String
    let exchange: String
    let industry: String
    let description: String
    let issueType: String
    let sector: String
    let employees: Int
    let tags: [String]
    let address: String
    let state: String
    let city: String
    // Zip, country, phone
}



//struct FetchIntradayPrice: Codable {
//    // let date: String                    //"2017-12-15",
//    // let minute: String                  //"09:30",
//    // let label: String                   // "09:30 AM",
//    let open: Double?                     //143.98,
//    let marketClose: Double?             //143.775,
//    let marketHigh: Double?              //143.98,
//    let marketLow: Double?               //143.775,
//    let marketAverage: Double?           //143.889,
//    let marketVolume: Int?               //3070,
//    let marketNotional: Double?          //441740.275,
//    let marketNumberOfTrades: Int?       //20,
//    let marketChangeOverTime: Double?     //-0.004,
//}


