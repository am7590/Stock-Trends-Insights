//
//  CurrencyView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/25/22.
//

import SwiftUI

struct CurrencyView: View {
    
    @ObservedObject var viewModel = CurrencyViewModel()
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                Text("Loading...")
            case .error(let error):
                Text("Error loading data: \(error)")
            default:
                VStack(alignment: .leading, spacing: 16) {
                    HStack{
                        
                        Text("Currency Exchange")
                            .font(.largeTitle.bold())
                        //.foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding(.vertical, 5)
                    
                    ScrollView(.horizontal) {
                        VStack(alignment: .leading, spacing: 16) {
                            
                            
                            HStack {
                                if let firstCurrencyList = viewModel.currencies?[0] {
                                    ForEach(firstCurrencyList, id: \.priceToday) { currency in
                                        
                                        let percentDifference = String(currency.difference.1!)
                                        SmallCellView(title: currency.currency, count: String(currency.truncatedPriceToday), percentChange: String(percentDifference), image: "", isPositive: currency.difference.2 ?? false)
                                        
                                    }
                                }
                                
                            }
                            
                            HStack {
                            if let firstCurrencyList = viewModel.currencies?[1] {
                                ForEach(firstCurrencyList, id: \.priceToday) { currency in
                                    
                                    let percentDifference = String(currency.difference.1!)
                                    SmallCellView(title: currency.currency, count: String(currency.truncatedPriceToday), percentChange: String(percentDifference), image: "", isPositive: currency.difference.2 ?? false)
                                    
                                }
                            }
                            
                        }
                        }
                        
                    }
                    
                }
            }
            
        }.onAppear {
            viewModel.load()
        }
        .frame(height: 300)
        .padding(.horizontal)
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView()
    }
}
