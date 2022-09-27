//
//  WatchlistViewModel.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/27/22.
//

import SwiftUI

@MainActor class WatchlistViewModel: StockAppViewModel {
    let service = IEXApiService()
    
    @Published var tickerChartdata: [Double] = []
    @Published var state: State = .loading
    
    func load() {
        Task(priority: .medium) {
            let result = await IEXApiService().getTimeSeriesData(stock: WatchlistManager.shared.coreDataTicker)
            switch result {
            case .success(let response):
                self.tickerChartdata = []   // Keep data fresh
                for (index, item) in response.enumerated() {
                    //if index.isMultiple(of: 5) {
                        if let close = item.close {
                            tickerChartdata.append(Double(close))
                        }
                   // }
                }
                state = .loaded
                
                
            case .failure(let error):
                print("Could not load time series data: \(error)")
                state = .error(error.localizedDescription)
            }
        }
    }
}
