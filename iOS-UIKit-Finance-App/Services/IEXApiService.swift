//
//  IEXApiService.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/20/22.
//

import Foundation

protocol IEXServicable {
    func getLogo(stock: String) async -> Result<Logo, RequestError>
    func getCompanyInfo(stock: String) async -> Result<CompanyInfo, RequestError>
    func getStats(stock: String) async -> Result<Stats, RequestError>
}

struct IEXApiService: HTTPClient, IEXServicable {
    func getLogo(stock: String) async -> Result<Logo, RequestError> {
        return await sendRequest(endpoint: IEXEndpoint.logo(stock: stock), responseModel: Logo.self)
    }
    
    func getCompanyInfo(stock: String) async -> Result<CompanyInfo, RequestError> {
        return await sendRequest(endpoint: IEXEndpoint.companyInfo(stock: stock), responseModel: CompanyInfo.self)
    }

    func getStats(stock: String) async -> Result<Stats, RequestError> {
        return await sendRequest(endpoint: IEXEndpoint.stats(stock: stock), responseModel: Stats.self)
    }
}
