//
//  DividendsForcastView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/30/22.
//

import SwiftUI
import Charts

struct DividendsForcastView: View {
    var body: some View {
        Section(content: { DividendsForcastFlippingView().foregroundColor(Color.black) })
            .frame(width: UIScreen.main.bounds.size.width, height: 325, alignment: .leading)
    }
}

struct DividendsForcastDataView: View {
    let viewModel: DividendsForcastViewModel
    @State var chartData: [DividendData] = []
    
    var body: some View {
        VStack {
            
            HStack {
                
                
                
                if viewModel.hasDividendPrediction {
                    Text("The next dividend payout is \(viewModel.dividendsForcast![0].paymentDate)")
                        .font(.largeTitle.bold())
                } else {
                    Text("No dividend has been declared for \(WatchlistManager.shared.coreDataTicker).")
                        .font(.title)
                    + Text(" Below are past predictions.")
                        .font(.title)
                }
                
            }
            
            
            Chart  {
                ForEach(chartData) { product in
                    
                    BarMark(x: .value("name", product.name), y: .value("sales", product.count))
                    
                        .foregroundStyle(by: .value("month", product.month))
                    //.position(by: .value("month", product.month))
                }
            }
            .frame(height: 150)
        }
        .onAppear {
            if viewModel.dividendsForcastChartData.isEmpty {
                chartData = viewModel.dividendsHistoryChartData
            }
            
            // TODO: Implement
            //            else {
            //                chartData = viewModel.dividendsHistoryChartData += viewModel.dividendsForcastChartData
            //            }
            
        }
    }
}


struct DividendsForcastView_Previews: PreviewProvider {
    static var previews: some View {
        DividendsForcastView()
    }
}
