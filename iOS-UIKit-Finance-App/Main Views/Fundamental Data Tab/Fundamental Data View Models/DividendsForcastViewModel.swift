//
//  DividendsForcastViewModel.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 7/3/22.
//

import Foundation

@MainActor class DividendsForcastViewModel: StockAppViewModel {
    let service = IEXApiService()
    let stock: String = "AAPL"
    
    @Published var dividendsForcast: [DividendsForcast]?
    @Published var dividendsForcastChartData: [DividendData] = []
    @Published var dividendsHistory: [String:DividendHistory]?
    @Published var dividendsHistoryChartData: [DividendData] = []
    @Published var hasDividendPrediction: Bool = true
    @Published var state: State = .loading
    
    func load() {
        
        Task(priority: .medium) {
            let result = await service.getDividendsForcast(stock: stock)
            switch result {
            case .success(let response):
                print(response )
                self.dividendsForcast = response
                verifyPrediction(data: response[0])
                if let data = dividendsForcast?[0], hasDividendPrediction {
                    let paymentDate = data.paymentDate.suffix(5)
                    dividendsForcastChartData.append(DividendData(name: String(paymentDate), count: Double(data.amount!), month: String(paymentDate)))
                }
                
            case .failure(_):
                self.dividendsForcast = nil
            }
        }
        
        Task(priority: .medium) {
            let result = await service.getDividendHistory(stock: stock)
            switch result {
            case .success(let response):
                print(response )
                self.dividendsHistory = response
                if let history = dividendsHistory {
                    print("???")
                    print(history.keys)
                    for item in history {
                        print("zzz \(item)")
                        let dividendDate = item.key
                        if dividendDate != "Earnings History" {
                            if dividendsHistoryChartData.count == 6 {
                                break
                            }
                            dividendsHistoryChartData.append(DividendData(name: String(dividendDate.prefix(4)+"\nPrediction"), count: Double(item.value.epsEstimate)!, month: String(dividendDate.prefix(4))))
                            dividendsHistoryChartData.append(DividendData(name: String(dividendDate.prefix(4)+"\nDividend"), count: Double(item.value.epsActual)!, month: String(dividendDate.prefix(4))))
                        }
                    }
                }
                
            case .failure(_):
                self.dividendsHistory = nil
            }
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.state = self.dividendsHistory == nil || self.dividendsForcast == nil ? .loading : .loaded

        }
                        
    }
    
    private func verifyPrediction(data: DividendsForcast) {
        let dateAsString = data.paymentDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+00:00")//Add this
        let date = dateFormatter.date(from: dateAsString)
        let today = Date()
        print(date!)
        
        if today > date! {
            self.hasDividendPrediction = false
        }
    }
    
//    private func setupChartData() {
//
//    }
}
