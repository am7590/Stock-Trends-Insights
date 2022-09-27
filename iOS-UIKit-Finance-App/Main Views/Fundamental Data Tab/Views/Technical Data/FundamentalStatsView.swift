//
//  FundamentalStatsView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/14/22.
//

import SwiftUI

struct FundamentalStatsView: View {
    let size: Bool
    let stats: Stats
    
    var body: some View {
            VStack{
                HStack{
                    Text("Fundamentals")
                        .foregroundColor(.black)
                        .font(.largeTitle.bold())
                    
                    Spacer()
                    
                }
                if size {
                    HStack(spacing: 10) {
                        StatView(title: "Volatility", count: "87.57K", image: "newspaper", color: "Green")
                        StatView(title: "D-to-E", count: "27.57K", image: "paperclip", color: "Purple")
                    }
                    .padding(.top)
                } else {
                    VStack {
                        
                        HStack(spacing: 10) {
                            StatView(title: "Volatility", count: String(stats.beta?.truncate(places: 2) ?? 0), image: "newspaper", color: "Green")
                            StatView(title: "D-to-E", count: String(stats.debtToEquity?.truncate(places: 2) ?? 0), image: "paperclip", color: "Purple")
                        }
                        .padding(.top)
                        
                        HStack(spacing: 10) {
                            StatView(title: "Profit Margin", count: String(stats.profitMargin?.truncate(places: 2) ?? 0), image: "newspaper", color: "Green")
                            StatView(title: "Rev. per Share", count: "$"+String(stats.revenuePerShare?.truncate(places: 2) ?? 0), image: "paperclip", color: "Purple")
                        }
    
                        HStack(spacing: 10) {
                            StatView(title: "Price to Sales", count: String(stats.priceToSales ?? 0), image: "newspaper", color: "Green")
                            StatView(title: "Put-Call Ratio", count: String(stats.putCallRatio?.truncate(places: 2) ?? 0), image: "paperclip", color: "Purple")
                        }
    
//                                            HStack(spacing: 10) {
//                                                StatView(title: "Data 1", count: "87.57K", image: "newspaper", color: "Green")
//                                                StatView(title: "Data 2", count: "27.57K", image: "paperclip", color: "Purple")
//                                            }

                    }.padding(.top, -30)
                }
                    
                
                Spacer()
                
                
            }
            .padding(.horizontal)
    }
}

struct StatView: View {
    let title: String
    let count: String
    let image: String
    let color: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            Text(title)
            
            Text(count)
                .font(.title.bold())
                .foregroundColor(.green)
        }
        .foregroundColor(Color.black)
        .padding(.vertical,18)
        .padding(.horizontal,18)
        .frame(maxWidth: .infinity,alignment: .leading)
        .overlay(
                RoundedRectangle(cornerRadius: 16)
                
                    .stroke(.gray, lineWidth: 1)
                    // .shadow(.drop(radius: 2))
                    
        )
        // .background(Color.red)
        //.cornerRadius(15)
        
    }
}


//struct FundamentalStatsView_Previews: PreviewProvider {
//    static var previews: some View {
//        FundamentalStatsView(size: false, stats: <#Stats#>)
//    }
//}
