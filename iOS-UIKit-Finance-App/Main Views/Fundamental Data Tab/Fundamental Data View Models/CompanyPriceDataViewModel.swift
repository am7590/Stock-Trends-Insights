//
//  CompanyPriceDataViewModel.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 7/3/22.
//

import Foundation

@MainActor class CompanyPriceDataViewModel: StockAppViewModel {
    let service = IEXApiService()
    let stock: String = "AAPL"
    
    @Published var logo: Logo?
    @Published var companyInfo: CompanyInfo?
    @Published var state: State = .loading
    
    
    func load() {
        
        Task(priority: .medium) {
            let result = await service.getLogo(stock: stock)
            switch result {
            case .success(let response):
                print(response.url ?? "")
                self.logo = response
                
            case .failure(let error):
                self.logo = nil
            }
            state = self.logo == nil || self.companyInfo == nil ? .loading : .loaded
        }
        
        Task(priority: .medium) {
            let result = await service.getCompanyInfo(stock: stock)
            switch result {
            case .success(let response):
                print(response)
                self.companyInfo = response
                
            case .failure(let error):
                self.companyInfo = nil
            }
            state = self.logo == nil || self.companyInfo == nil ? .loading : .loaded
        }
        
    }
}
