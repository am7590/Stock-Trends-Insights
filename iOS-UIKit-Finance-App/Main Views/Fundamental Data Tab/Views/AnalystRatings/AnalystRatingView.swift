//
//  AnalystRatingView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/30/22.
//

import SwiftUI

struct AnalystRatingView: View {
    var body: some View {
        Section(content: { AnalystRatingFlippingView()
        })
        .frame(width: UIScreen.main.bounds.size.width, height: 400, alignment: .leading)
    }
}

struct AnalystRatingDataView: View {
    let analystRating: AnalystRatings
    let analystChartData: [StockDataPoint]
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                Text("Analyst Ratings")
                    .foregroundColor(.primary)
                    .font(.largeTitle.bold())
                Spacer()
            }
            
            DownloadStats(analystChartData: analystChartData)
            
            AnalystText(consensus: analystRating.isBullish, truncatedConsensusPrice: (analystRating.truncatedConsensusPrice!))
                .frame(height: 150)
            
            Spacer()
        }
        .padding()
    }
}


@ViewBuilder
func DownloadStats(analystChartData: [StockDataPoint]) -> some View {
    BarGraph(trend: analystChartData)
        .padding(.top, 5)
        .padding(.vertical,20)
}

@ViewBuilder
func AnalystText(consensus: Bool, truncatedConsensusPrice: String) -> some View {
    Text("Analysts are")
        .font(.title)
    //.bold()
    + Text(consensus ? " Bullish" : " Bearish")
        .font(.title)
        .bold()
        .foregroundColor(.green)
    + Text("  on \(WatchlistManager.shared.coreDataTicker) with a price target of")
        .font(.title)
    //.bold()
    + Text(" $\(truncatedConsensusPrice)")
        .font(.title)
        .bold()
        .foregroundColor(.green)
}

struct AnalystRatingView_Previews: PreviewProvider {
    static var previews: some View {
        AnalystRatingView()
    }
}

