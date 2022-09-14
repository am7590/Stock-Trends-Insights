//
//  FundamentalViewHolder.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 7/24/22.
//

import SwiftUI

import SwiftUI

struct FundamentalViewHolder: View {
    var body: some View {
        //List {
        ScrollView {
            VStack {
                CompanyHeaderView()
                CEODataView()
                AnalystRatingView()
                FirstTechnicalView()
                SecondTechnicalView()
                DividendsForcastView()
            }
        }
            
        //}
        //.listStyle(InsetGroupedListStyle())
    }
}

struct FundamentalViewHolder_Previews: PreviewProvider {
    static var previews: some View {
        FundamentalViewHolder()
    }
}
