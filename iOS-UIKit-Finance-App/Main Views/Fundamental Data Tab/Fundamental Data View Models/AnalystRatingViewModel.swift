//
//  AnalystRatingViewModel.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 7/3/22.
//

import Foundation

@MainActor class AnalystRatingViewModel: StockAppViewModel {
    let service = IEXApiService()
    let stock: String = "AAPL"
    
    @Published var analystRatings: [AnalystRatings]?
    @Published var state: State = .loading
    
    func load() {
        
        Task(priority: .medium) {
            let result = await service.getAnalystRatings(stock: stock)
            switch result {
            case .success(let response):
                print(response ?? "")
                self.analystRatings = response
                
            case .failure(let error):
                self.analystRatings = nil
            }
            state = self.analystRatings == nil  ? .loading : .loaded
        }
        
        Task(priority: .medium) {
            let result = await service.getDummyData(stock: "TSLA", socialMedia: "Twitter")
            switch result {
            case .success(let response):
                print("zzz \(response)")
                //self.analystRatings = response
                
            case .failure(let error):
                print("zzz error: \(error)")
                //self.analystRatings = nil
            }
            // state = self.analystRatings == nil  ? .loading : .loaded
        }
    }
}
