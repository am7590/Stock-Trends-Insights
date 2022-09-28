//
//  ChartViewModel.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/27/22.
//

import Foundation

@MainActor class ChartViewModel: StockAppViewModel {
    let service = IEXApiService()
    
    @Published var tickerChartdata: [Double] = []
    @Published var state: State = .loading
    
    func load() {
        Task(priority: .medium) {
            let result = await IEXApiService().getTimeSeriesData(stock: WatchlistManager.shared.coreDataTicker)
            switch result {
            case .success(let response):
                self.tickerChartdata = []   // Keep data fresh
                
                
                DispatchQueue.main.async {
                    for (index, item) in response.enumerated() {
                        if let close = item.close {
                            self.tickerChartdata.append(close)
                        }
                    }
                    self.state = .loaded
                    print("zz done loading")
                }
                
                
                
                
            case .failure(let error):
                print("Could not load time series data: \(error)")
                state = .error(error.localizedDescription)
            }
        }
    }
    
    func dateFromString(dateAsString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+00:00")//Add this
        let date = dateFormatter.date(from: dateAsString)
        return date!
    }
}
