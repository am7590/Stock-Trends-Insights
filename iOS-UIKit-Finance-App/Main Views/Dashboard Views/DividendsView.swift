//
//  DividendsView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/29/22.
//

import SwiftUI

struct DividendsView: View {
    var body: some View {
        VStack {
//["1 Day", "1 Week", "1 Month", "3 Months"]
            
            Row(ticker: "TSLA", values: ["0.25", "-0.04", "1.14", "2.21"])
            Row(ticker: "GME", values: ["-0.45", "1.34", "1.14", "0.03"])
            Row(ticker: "AAPL", values: ["-0.71", "3.35", "0.01", "-1.54"])
        }.padding()
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(UIColor.green), lineWidth: 3)
        )
        .frame(width: UIScreen.main.bounds.size.width, height: 215, alignment: .center)
            .cornerRadius(16)
            
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

struct DividendsView_Previews: PreviewProvider {
    static var previews: some View {
        DividendsView()
    }
}
