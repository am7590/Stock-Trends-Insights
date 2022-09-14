//
//  FundamentalStatsView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/14/22.
//

import SwiftUI

struct FundamentalStatsView: View {
    let size: Bool
    
    var body: some View {
        VStack{
            
            HStack(){
                
                Text("Fundamentals")
                    .foregroundColor(.black)
                    .font(.largeTitle.bold())
                
                Spacer()
                
            }
            if size {
                HStack(spacing: 10){
                    StatView(title: "Volatility", count: "87.57K", image: "newspaper", color: "Green")
                    StatView(title: "D-to-E", count: "27.57K", image: "paperclip", color: "Purple")
                }
                .padding(.top)
            } else {
                VStack {
                    
                    HStack(spacing: 10){
                        StatView(title: "Volatility", count: "87.57K", image: "newspaper", color: "Green")
                        StatView(title: "Debt to Equity", count: "27.57K", image: "paperclip", color: "Purple")
                    }
                    .padding(.top)
                    
                    HStack(spacing: 10) {
                        StatView(title: "Profit Margin", count: "87.57K", image: "newspaper", color: "Green")
                        StatView(title: "Rev. per Share", count: "27.57K", image: "paperclip", color: "Purple")
                    }
                    //
                    //                    HStack(spacing: 10) {
                    //                        StatView(title: "Data 1", count: "87.57K", image: "newspaper", color: "Green")
                    //                        StatView(title: "Data 2", count: "27.57K", image: "paperclip", color: "Purple")
                    //                    }
                    //
                    //                    HStack(spacing: 10) {
                    //                        StatView(title: "Data 1", count: "87.57K", image: "newspaper", color: "Green")
                    //                        StatView(title: "Data 2", count: "27.57K", image: "paperclip", color: "Purple")
                    //                    }
                }
            }
            
            
        }
        .frame(maxWidth: .infinity)
        .padding(15)
        
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.white.shadow(.drop(radius: 2)))
        }
    }
    
}

struct StatView: View {
    let title: String
    let count: String
    let image: String
    let color: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            
            HStack{
                Image(systemName: image)
                    .font(.caption.bold())
                    .foregroundColor(Color.white)
                    .padding(6)
                    .background(Color.black)
                    .cornerRadius(8)
                
                Text(title)
            }
            
            Text(count)
                .font(.title.bold())
        }
        .foregroundColor(Color.black)
        .padding(.vertical,22)
        .padding(.horizontal,18)
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(Color.red)
        .cornerRadius(15)
    }
}



struct FundamentalStatsView_Previews: PreviewProvider {
    static var previews: some View {
        FundamentalStatsView(size: false)
    }
}
