//
//  WatchlistManager.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/25/22.
//

import Foundation

class WatchlistManager {
    
    var tickerSelected: String = "AAPL" {
        didSet {
            print("ticker is now \(String(describing: self.tickerSelected))")
            fetchTimeSeriesData()
        }
    }
    
    static let shared = WatchlistManager()
    
    public var stockData: [TimeSeriesHistoricalData]? {
        didSet {
            print("stock data: \(stockData)")
        }
    }
    
    private func fetchTimeSeriesData() {
        Task(priority: .medium) {
            let result = await IEXApiService().getTimeSeriesData(stock: tickerSelected)
            switch result {
            case .success(let response):
                self.stockData = response
            case .failure(let error):
                print("Could not load time series data: \(error)")
                self.stockData = nil
            }
        }
    }
}
