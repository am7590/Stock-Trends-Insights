//
//  AnalystRatingView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/30/22.
//

import SwiftUI

var weekDownloads: [StockDataPoint] = [
    StockDataPoint(value: 56, title: "S. Buy", color: Color.green),
    StockDataPoint(value: 78, title: "Buy", color: Color.green.opacity(0.8)),
    StockDataPoint(value: 42, title: "Hold", color: Color.gray),
    StockDataPoint(value: 12, title: "Sell", color: Color.red.opacity(0.8)),
    StockDataPoint(value: 5, title: "S. Sell", color: Color.red),
]

struct AnalystRatingView: View {
    
    var body: some View {
        Section(content: { AnalystRatingFlippingView()        
            .foregroundColor(Color.black) })
            .frame(width: UIScreen.main.bounds.size.width, height: 400, alignment: .leading)
    }
}

struct AnalystRatingDataView: View {
    let analystRating: AnalystRatings
    
    var body: some View {
        
        //        if let subkey = analystRating.subkey, let key = analystRating.key {
        //            Text(String(describing: "subkey (key): \(subkey) (\(key)) "))
        //        }
        //
        //        if let id = analystRating.id, let symbol = analystRating.symbol {
        //            Text(String(describing: "Id: \(id) for \(symbol)"))
        //        }
        //
        //        if let analystCount = analystRating.analystCount, let marketConsensusTargetPrice = analystRating.marketConsensusTargetPrice {
        //            Text(String(describing: "\(analystCount) analysts predict a price of \(marketConsensusTargetPrice)"))
        //        }
        //
        //        if let marketConsensus = analystRating.marketConsensus, let consensusDate = analystRating.consensusDate {
        //            Text(String(describing: "market consensus \(marketConsensus) on \(consensusDate)"))
        //        }
        
        
        VStack(spacing: 0) {
            
            HStack {
                Text("Analyst Ratings")
                    .foregroundColor(.black)
                    .font(.largeTitle.bold())
                Spacer()
            }
            
            DownloadStats()
            
            Group {
                Text("Analysts are")
                    .font(.title)
                //.bold()
                + Text(" bullish")
                    .font(.title)
                    .bold()
                    .foregroundColor(.green)
                + Text("  on TSLA with a price target of")
                    .font(.title)
                //.bold()
                + Text(" $189.12")
                    .font(.title)
                    .bold()
                    .foregroundColor(.green)
            }
            .frame(height: 150)
            
            Spacer()
        }
        .padding()
    }
}


@ViewBuilder
func DownloadStats() -> some View {
    
        
        BarGraph(downloads: weekDownloads)
            .padding(.top, 5)
    .padding(.vertical,20)
}

struct AnalystRatingView_Previews: PreviewProvider {
    static var previews: some View {
        AnalystRatingView()
    }
}

