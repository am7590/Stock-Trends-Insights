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
    func getNews(stock: String) async -> Result<[News], RequestError>
    func getDividends(stock: String) async -> Result<[Dividends], RequestError>
    func getInsitutionalOwnership(stock: String) async -> Result<[InstitutionalOwnership], RequestError>
    func getInsiderTransactions(stock: String) async -> Result<[InsiderTransactions], RequestError>
    func getCeoCompensation(stock: String) async -> Result<CeoCompensation, RequestError>
    func getDividendsForcast(stock: String) async -> Result<[DividendsForcast], RequestError>
    func getAnalystRatings(stock: String) async -> Result<[AnalystRatings], RequestError>
    func getDummyData(stock: String, socialMedia: String) async -> Result<Sentiment, RequestError>
    func getSectorData() async -> Result<[Sector], RequestError>
    func getCurrencyData() async -> Result<[Currency], RequestError>
    func getAnalystData(stock: String) async -> Result<[Analyst], RequestError>
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
    
    func getNews(stock: String) async -> Result<[News], RequestError> {
        return await sendRequest(endpoint: IEXEndpoint.news(stock: stock), responseModel: [News].self)
    }
    
    func getDividends(stock: String) async -> Result<[Dividends], RequestError> {
        return await sendRequest(endpoint: IEXEndpoint.dividends(stock: stock), responseModel: [Dividends].self)
    }
    
    func getInsitutionalOwnership(stock: String) async -> Result<[InstitutionalOwnership], RequestError> {
        return await sendRequest(endpoint: IEXEndpoint.institutionalOwnership(stock: stock), responseModel: [InstitutionalOwnership].self)
    }
    
    func getInsiderTransactions(stock: String) async -> Result<[InsiderTransactions], RequestError> {
        return await sendRequest(endpoint: IEXEndpoint.insiderTransactions(stock: stock), responseModel: [InsiderTransactions].self)
    }
    
    func getCeoCompensation(stock: String) async -> Result<CeoCompensation, RequestError> {
        return await sendRequest(endpoint: IEXEndpoint.ceoCompensation(stock: stock), responseModel: CeoCompensation.self)
    }
    
    func getDividendsForcast(stock: String) async -> Result<[DividendsForcast], RequestError> {
        return await sendRequest(endpoint: IEXEndpoint.dividendsForcast(stock: stock), responseModel: [DividendsForcast].self)
    }
    
    func getAnalystRatings(stock: String) async -> Result<[AnalystRatings], RequestError> {
        return await sendRequest(endpoint: IEXEndpoint.analystRatings(stock: stock), responseModel: [AnalystRatings].self)
    }
    
    func getDummyData(stock: String, socialMedia: String) async -> Result<Sentiment, RequestError> {
        return await sendRequest(endpoint: IEXEndpoint.dummyData(stock: stock, socialMedia: socialMedia), responseModel: Sentiment.self)
    }
    
    func getSectorData() async -> Result<[Sector], RequestError> {
        return await sendRequest(endpoint: IEXEndpoint.sector, responseModel: [Sector].self)
    }
    
    func getCurrencyData() async -> Result<[Currency], RequestError> {
        return await sendRequest(endpoint: IEXEndpoint.currency, responseModel: [Currency].self)
    }
    
    func getAnalystData(stock: String) async -> Result<[Analyst], RequestError> {
        return await sendRequest(endpoint: IEXEndpoint.analyst(stock: stock), responseModel: [Analyst].self)
    }
}
