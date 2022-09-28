//
//  WatchlistView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 8/25/22.
//

import SwiftUI

struct WatchlistView: View {
        
    @ObservedObject var viewModel = WatchlistViewModel()
    
    var body: some View  {
        
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .error(let error):
                Text("Error loading: \(error)")
            case .loaded:
                VStack(spacing: 15) {
                    HStack{
                        
                        Text("My Watchlist")
                            .font(.largeTitle.bold())
                        //.foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding(.vertical, 5)
                                        
                    let coins = [
                        // TODO: Add price change data (find data source?)
                        ChartDataModel(id: WatchlistManager.shared.coreDataTicker, symbol: WatchlistManager.shared.coreDataTicker, name: WatchlistManager.shared.companyInfo?.companyName ?? ".", image: "", current_price: viewModel.tickerChartdata.last ?? 0.0, price_change: 0.25, last_7days_price: viewModel.tickerChartdata),
                    ]
                    
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 8){
                            CardView(stock: coins[0])
                            Divider()
                                .background(.black)
//                            CardView(coin: coins[1])
//                            Divider()
//                                .background(.black)
                        }
                    }
                }
               
            case .empty(_):
                Text("No data to display")
            }
        }
        .frame(height: 200)
        .padding(.horizontal)
        .onAppear {
            viewModel.load()
        }
    }
}
