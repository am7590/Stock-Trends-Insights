//
//  StatsView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/29/22.
//

import SwiftUI

struct StatsView: View {
    var body: some View {
        
        FundamentalDataView(systemImage: "list.dash", title: "My watchlist") {
            let stocks = ["TSLA", "GME", "AAPL"]
            
            VStack {
                    ForEach(stocks, id: \.self) { stock in
                        Section {
                            Text(stock)
                                .font(.headline)
                        }
                        
                    }
                
            }
            
        }
        
    }
    
}


struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
