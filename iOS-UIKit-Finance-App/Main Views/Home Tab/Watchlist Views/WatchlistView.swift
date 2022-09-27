//
//  WatchlistView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 8/25/22.
//

import SwiftUI

struct WatchlistView: View {
    
    @State var tickerChartdata: [Double] = []
    
    var body: some View  {
        VStack(spacing: 15) {
            HStack{
                
                Text("My Watchlist")
                    .font(.largeTitle.bold())
                //.foregroundColor(.white)
                
                Spacer()
            }
            .padding(.vertical, 5)
            
            let coins = [
                CryptoModel(id: "id", symbol: "AAPL", name: "Tesla, Inc.", image: "tsla", current_price: 360.12, last_updated: "5m", price_change: 0.25, last_7days_price: tickerChartdata),
                CryptoModel(id: "id", symbol: "GME", name: "GameStop, Inc.", image: "gme", current_price: 140.78, last_updated: "5m", price_change: -1.25, last_7days_price: DummyData.data4)
            ]
            
            ScrollView(.vertical, showsIndicators: false) {
                
                
                VStack(spacing: 8){
                    CardView(coin: coins[0])
                    Divider()
                        .background(.black)
                    CardView(coin: coins[1])
                    Divider()
                        .background(.black)
                }
                
            }
        }
        .frame(height: 300)
        .padding(.horizontal)
        .onAppear {
            
            print("data: \(WatchlistManager.shared.stockData)")
            if let stockData = WatchlistManager.shared.stockData {
                for (index, item) in stockData.enumerated() {
                    if index.isMultiple(of: 10) {
                        if let close = item.close {
                            tickerChartdata.append(Double(close))
                        }
                    }
                }
            }
            
            print("tickerChartdata: \(tickerChartdata)")
            
        }
    }
}
