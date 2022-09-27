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
    @Published var analystChartData: [StockDataPoint]?
    @Published var state: State = .loading
    
    func load() {
        
        Task(priority: .medium) {
            let result = await service.getAnalystRatings(stock: stock)
            switch result {
            case .success(let response):
                print("zzz \(response)")
                self.analystRatings = response
                
            case .failure(let error):
                self.analystRatings = nil
            }
            
        }

        Task(priority: .medium) {
            let result = await service.getAnalystData(stock: stock)
            switch result {
            case .success(let response):
                print("zzz \(response)")
                let data = response[0].recommendationTrend.trend[0]
                let chartData: [StockDataPoint] = [
                    StockDataPoint(value: CGFloat(integerLiteral: data.strongBuy) , title: "S. Buy", color: .green),
                    StockDataPoint(value: CGFloat(integerLiteral: data.buy), title: "Buy", color: .green.opacity(0.8)),
                    StockDataPoint(value: CGFloat(integerLiteral: data.hold), title: "Hold", color: .gray),
                    StockDataPoint(value: CGFloat(integerLiteral: data.sell), title: "Sell", color: .red.opacity(0.8)),
                    StockDataPoint(value: CGFloat(integerLiteral: data.strongSell), title: "S. Sell", color: .red)
                ]
                self.analystChartData = chartData
                
            case .failure(let error):
                print("zzz error: \(error)")
                self.analystChartData = nil
            }
            // state = self.analystRatings == nil  ? .loading : .loaded
        }

        // This is a workaround bug fix. Having weird issue with Task. Going to remove DispatchQueue code once resolved.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.state = self.analystRatings == nil || self.analystChartData == nil ? .loading : .loaded
        }
        
        print("state \(state)")
        
    }
}
