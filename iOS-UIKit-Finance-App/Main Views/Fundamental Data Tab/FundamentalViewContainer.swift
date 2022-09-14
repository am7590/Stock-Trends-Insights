//
//  FundamentalViewContainer.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/13/22.
//

import SwiftUI

struct FundamentalViewContainer: View {
    var body: some View {
//        stackView.addArrangedSubview(UIHostingController(rootView: CompanyHeaderView()).view)
//        stackView.addArrangedSubview(UIHostingController(rootView: CEODataView()).view)
//        stackView.addArrangedSubview(UIHostingController(rootView: AnalystRatingView()).view)
//        stackView.addArrangedSubview(UIHostingController(rootView: FirstTechnicalView()).view)
//        stackView.addArrangedSubview(UIHostingController(rootView: SecondTechnicalView()).view)
//        stackView.addArrangedSubview(UIHostingController(rootView: DividendsForcastView()).view)
        ScrollView {
            VStack {
                CompanyHeaderView()
                Section(content: { ChartView().foregroundColor(Color.black) })
                    .frame(width: UIScreen.main.bounds.size.width, height: 375, alignment: .leading)
                
                AnalystRatingView()
                CEODataView()
                    .padding(.top, 70)
//                AnalystRatingView()
//                SecondTechnicalView()
                DividendsForcastView()
                    .padding()
                    .padding(.top, 40)
                
                FirstTechnicalView()
                    .padding(.top, 40)
            }
        }
    }
}

struct FundamentalViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        FundamentalViewContainer()
    }
}
