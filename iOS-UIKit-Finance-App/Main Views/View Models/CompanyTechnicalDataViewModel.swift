//
//  CompanyTechnicalDataViewModel.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 7/3/22.
//

import Foundation

@MainActor class CompanyTechnicalDataViewModel: ObservableObject {
    let service = IEXApiService()
    let stock: String = "TSLA"
    
    enum State {
        case loading
        case loaded
        case empty(String)
        case error(String)
    }
    
    @Published var stats: Stats?
    // @Published var companyInfo: CompanyInfo?
    @Published var state: State = .loading
    
    
    func load() {
        
        Task(priority: .medium) {
            let result = await service.getStats(stock: stock)
            switch result {
            case .success(let response):
                print(response ?? "")
                self.stats = response
                
            case .failure(let error):
                self.stats = nil
            }
            state = self.stats == nil ? .loading : .loaded
        }
        
//        Task(priority: .medium) {
//            let result = await service.getCompanyInfo(stock: stock)
//            switch result {
//            case .success(let response):
//                print(response)
//                self.companyInfo = response
//
//            case .failure(let error):
//                self.companyInfo = nil
//            }
//            state = self.logo == nil || self.companyInfo == nil ? .loading : .loaded
//        }
        
    }
}
