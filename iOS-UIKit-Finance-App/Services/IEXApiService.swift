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
    func getNews(stock: String) async -> Result<News, RequestError>
    func getDividends(stock: String) async -> Result<Dividends, RequestError>
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
    
    func getNews(stock: String) async -> Result<News, RequestError> {
        return await sendRequest(endpoint: IEXEndpoint.news(stock: stock), responseModel: News.self)
    }
    
    func getDividends(stock: String) async -> Result<Dividends, RequestError> {
        return await sendRequest(endpoint: IEXEndpoint.dividends(stock: stock), responseModel: Dividends.self)
    }
}
