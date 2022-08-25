//
//  DividendsView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/29/22.
//

import SwiftUI

struct GridView: View {
    var body: some View {
        VStack {
            
            HStack{
                
                Text("Some Title")
                    .font(.largeTitle.bold())
                //.foregroundColor(.white)
                
                Spacer()
            }
            .padding(.vertical, 5)
//["1 Day", "1 Week", "1 Month", "3 Months"]
            
            Row(ticker: "TSLA", values: ["0.25", "-0.04", "1.14", "2.21"])
            Row(ticker: "GME", values: ["-0.45", "1.34", "1.14", "0.03"])
            Row(ticker: "AAPL", values: ["-0.71", "3.35", "0.01", "-1.54"])
        }.padding(15)
            .background(
            
                // RoundedRectangle(cornerRadius: 20)
                //    .fill(Color.black)
            )
            .padding(.vertical,20)
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}


struct Row: View {
    var ticker: String
    var values: [String]
    var enableColors: Bool = true
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Text(ticker)
                    .frame(width: 50)
                    .foregroundColor(.black)
                HStack {
                    Divider()
                        .background(.black)
                }.frame(height: 50)
                
                ForEach(Array(values.enumerated()), id: \.offset) { index, value in
                    Text(value).frame(width: 50, height: 50, alignment: .center)
                        .background(enableColors && value.first == "-" ? .red : .green)
                }
            }
        }
    }
}
