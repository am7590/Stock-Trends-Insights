//
//  IEXApiService.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/20/22.
//

import Foundation

protocol IEXServicable {
    func getLogo() async -> Result<Logo, RequestError>
    func getCompanyInfo(id: Int) async -> Result<CompanyInfo, RequestError>
}

struct IEXApiService: HTTPClient, IEXServicable {
    func getLogo() async -> Result<Logo, RequestError> {
        return await sendRequest(endpoint: IEXEndpoint.logo(stock: "TSLA"), responseModel: Logo.self)
    }
    
    func getCompanyInfo(id: Int) async -> Result<CompanyInfo, RequestError> {
        return await sendRequest(endpoint: IEXEndpoint.companyInfo(stock: "TSLA"), responseModel: CompanyInfo.self)
    }
}
