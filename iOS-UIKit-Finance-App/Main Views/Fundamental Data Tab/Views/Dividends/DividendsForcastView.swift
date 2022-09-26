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
            .frame(width: UIScreen.main.bounds.size.width, height: 350, alignment: .leading)
    }
}

struct DividendsForcastDataView: View {
    let dividendsForcast: DividendsForcast
    
    var body: some View {
        
        //        if let adjAmount = dividendsForcast.adjustedAmount, let amount = dividendsForcast.amount {
        //            Text(String(describing: "Amount (adjusted): \(amount) (\(adjAmount)) "))
        //        }
        //
        //        if let declaredDate = dividendsForcast.declaredDate, let disbursementType = dividendsForcast.disbursementType {
        //            Text(String(describing: "Announced \(declaredDate) with \(disbursementType) disbursement  "))
        //        }
        //
        //        if let disbursementAmount = dividendsForcast.disbursementAmount, let frequency = dividendsForcast.frequency {
        //            Text(String(describing: "With \(disbursementAmount) every \(frequency)"))
        //        }
        //
        //        if let exData = dividendsForcast.exDate {
        //            Text("Must be purchased before \(exData) to get dividend.")
        //        }
        //
        //        if let paymentDate = dividendsForcast.paymentDate {
        //            Text("Dividend pays out on \(paymentDate)")
        //        }
        //
        //        if let sharesReceived = dividendsForcast.sharesReceived {
        //            Text("with each share receiving \(sharesReceived)")
        //        }
        
        VStack {
            HStack {
                Text("The next dividend payout is 7/14")
                    .font(.largeTitle.bold())
                Spacer()
            }
                        
            Chart  {
                ForEach(data) { product in
                    
                    BarMark(x: .value("name", product.name), y: .value("sales", product.count))
                    
                        .foregroundStyle(by: .value("month", product.month))
                    //.position(by: .value("month", product.month))
                }
            }
            .frame(height: 150)
        }
    }
}


struct DividendsForcastView_Previews: PreviewProvider {
    static var previews: some View {
        DividendsForcastView()
    }
}
