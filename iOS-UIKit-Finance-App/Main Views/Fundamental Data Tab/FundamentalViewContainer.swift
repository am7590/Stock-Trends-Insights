//
//  FundamentalViewContainer.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/13/22.
//

import SwiftUI

struct FundamentalViewContainer: View {
    var body: some View {
        
        ScrollView {
            VStack {
                CompanyHeaderView()
                
                Section(content: {
                    ChartView()
                        .foregroundColor(.primary)
                })
                .frame(width: UIScreen.main.bounds.size.width, height: 275, alignment: .leading)
                .padding(.top, -50)
                
                DividendsForcastView()
                    .padding(.top, 35)
                
                    .padding()
                //                    .padding(.top, 40)
                
                // This will be in the next beta version
                // TODO: Make new API endpoint to retrieve CEO png
                //                CEODataView()
                //                    .padding(.top, 70)
                
                AnalystRatingView()
                
                FirstTechnicalView()
                    .padding()
            }
        }
    }
}

struct FundamentalViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        FundamentalViewContainer()
    }
}
