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
            .foregroundColor(Color.black) })
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
                    .foregroundColor(.black)
                    .font(.largeTitle.bold())
                Spacer()
            }
            
            DownloadStats(analystChartData: analystChartData)
            
            AnalystText(consensus: analystRating.isBullish, targetPrice: analystRating.truncatedConsensusPrice!)
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
func AnalystText(consensus: Bool, targetPrice: Double) -> some View {
        Text("Analysts are")
            .font(.title)
        //.bold()
        + Text(consensus ? " Bullish" : " Bearish")
            .font(.title)
            .bold()
            .foregroundColor(.green)
        + Text("  on {TSLA} with a price target of")
            .font(.title)
        //.bold()
        + Text(" $\(targetPrice)")
            .font(.title)
            .bold()
            .foregroundColor(.green)
}

struct AnalystRatingView_Previews: PreviewProvider {
    static var previews: some View {
        AnalystRatingView()
    }
}

