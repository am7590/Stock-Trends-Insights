//
//  HeaderFlipViews.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/14/22.
//

import SwiftUI

struct CompanyHeaderFront: View {
    @StateObject var viewModel = CompanyHeaderViewModel()
    @Binding var degree: Double
    
    var body: some View {
        
        //if let companyName = viewModel.companyInfo?.companyName {
        Group {
            switch viewModel.state {
            case .loaded:
                if let companyInfo = viewModel.companyInfo, let logo = viewModel.logo {
                    CompanyHeaderDataView(companyInfo: companyInfo, logo: logo)
                }
                
            case .error(let error):
                Text(error)
            case .empty(let empty):
                Text(empty)
            default:
                Text("Loading...")
            }
        }
        
        .onAppear(perform: { viewModel.load() })
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 1, y: 0, z: 0))
        //}
    }
}


struct CompanyHeaderBack: View {
    @Binding var degree: Double
    @StateObject var viewModel = CompanyHeaderViewModel()
    
    var body: some View {
        
        Form {
            if let symbol = viewModel.companyInfo?.symbol {
                Label("More about " + symbol, systemImage: "info.circle.fill")
                    .font(.title3)
                    .padding(.horizontal)
            }
            
            if let description = viewModel.companyInfo?.description {
                Text(description)
            }
            
            if let website = viewModel.companyInfo?.website {
                Button(action: {}, label:{ Link("Learn more", destination: URL(string: website)!)})
            }
            
        }.onAppear(perform: { viewModel.load() })
        
            .rotation3DEffect(Angle(degrees: degree), axis: (x: 1, y: 0, z: 0))
    }
}
