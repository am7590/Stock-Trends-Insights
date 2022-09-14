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
                CEODataView()
                AnalystRatingView()
                AnalystRatingView()
                FirstTechnicalView()
                SecondTechnicalView()
                DividendsForcastView()
            }
        }
    }
}

struct FundamentalViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        FundamentalViewContainer()
    }
}
