//
//  WatchlistView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 8/25/22.
//

import SwiftUI

struct WatchlistView: View {
    var body: some View  {
        VStack(spacing: 15){
            HStack{
                
                Text("My Watchlist")
                    .font(.largeTitle.bold())
                    //.foregroundColor(.white)
                
                Spacer()
            }
            .padding(.vertical, 5)
            
            let coins = [CryptoModel(id: "id", symbol: "TSLA", name: "Tesla, Inc.", image: "tsla", current_price: 23452.13366222961, last_updated: "5m", price_change: -0.25, last_7days_price: DummyData.data2), CryptoModel(id: "id", symbol: "GME", name: "GameStop, Inc.", image: "gme", current_price: 23452.13366222961, last_updated: "5m", price_change: 2.34, last_7days_price: DummyData.data4)]
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10){
                        ForEach(coins){coin in
                            VStack(spacing: 8){
                                CardView(coin: coin)
                                Divider()
                                    .background(.black)
                            }
                            // .padding(.horizontal)
                            .padding(.vertical,8)
                        }
                    
                }
            }
        }
        .padding(15)
        .background(
        
            // RoundedRectangle(cornerRadius: 20)
                //.fill(Color.black)
        )
        .padding(.vertical,20)
        
        
    }
}
