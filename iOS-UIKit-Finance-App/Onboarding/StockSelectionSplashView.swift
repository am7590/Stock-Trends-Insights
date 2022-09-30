//
//  StockSelectionSplashView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/25/22.
//

import SwiftUI

struct StockSelectionSplashView: View {
    
    @State var stockSelected = WatchlistManager.shared.tickerSelected
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Text("Please select a stock")
                .font(.largeTitle.bold())
                .padding(.top, 24)
            
            GroupBox(label: Label("Beta Test Info", systemImage: "info.circle")) {
                
                Divider()
                
                Text("The finished app will allow you to track your entire portfolio. For this beta test, please pick only one stock.")
            }
            .frame(maxHeight: .infinity)
            .groupBoxStyle(ColoredGroupBox(color: colorScheme == .dark ? Color.blue : Color.yellow))
            .padding(.horizontal)
            
            
            VStack {
                ButtonView(title: "AAPL")
                ButtonView(title: "MSFT")
                ButtonView(title: "INTC")
                ButtonView(title: "IBM")
            }
            .padding()
            
            HStack {
                Spacer()
                Image(systemName: "arrow.right")
                    .background(Circle().fill(.green)
                        .frame(width: 50, height: 50))
                    .padding(50)
                    .onTapGesture {
                        NotificationCenter.default.post(name: NSNotification.FinishOnboarding,
                                                        object: nil)
                    }
                
            }
        }
    }
}

struct StockSelectionSplashView_Previews: PreviewProvider {
    static var previews: some View {
        StockSelectionSplashView()
    }
}
