//
//  FirstTechnicalView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/29/22.
//

import SwiftUI

struct FirstTechnicalView: View {
    
    var body: some View {
        Section(content: {
            FirstTechnicalViewFlippingView().foregroundColor(Color.black)
            
        })
        .frame(width: UIScreen.main.bounds.size.width, height: 300, alignment: .leading)
    }
}

struct FirstTechnicalDataView: View {
    let stats: Stats
    
    var body: some View {
        FundamentalStatsView(size: false)
        //        if let beta = stats.beta, let EBITDA = stats.EBITDA {
        //            Text(String(describing: "beta: \(beta), EBITDA: \(EBITDA)"))
        //        }
        //
        //        if let totalCash = stats.totalCash, let currentDebt = stats.currentDebt {
        //            Text(String(describing: "totalCash: \(totalCash), currentDebt: \(currentDebt)"))
        //        }
        //
        //        if let revenue = stats.revenue, let grossProfit = stats.grossProfit {
        //            Text(String(describing: "revenue: \(revenue), grossProfit: \(grossProfit)"))
        //        }
        //
        //        if let revenuePerShare = stats.revenuePerShare, let revenuePerEmployee = stats.revenuePerEmployee {
        //            Text(String(describing: "revenuePerShare: \(revenuePerShare), revenuePerEmployee: \(revenuePerEmployee)"))
        //        }
        //
        //        if let debtToEquity = stats.debtToEquity, let profitMargin = stats.profitMargin {
        //            Text(String(describing: "debtToEquity: \(debtToEquity), profitMargin: \(profitMargin)"))
        //        }
    }
}



struct CompanyTechnicalData_Previews: PreviewProvider {
    static var previews: some View {
        FirstTechnicalView()
    }
}

