//
//  CompanyTechnicalData.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/29/22.
//

import SwiftUI

struct CompanyTechnicalDataView: View {
    @StateObject var viewModel = CompanyTechnicalDataViewModel()
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loaded:
                
                Color.pink
                
                VStack {
                    Text(String(describing: viewModel.stats?.companyName))
                    Text(String(describing: viewModel.stats?.employees))
                    Text(String(describing: viewModel.stats?.EBITDA))
                    Text(String(describing: viewModel.stats?.avg10Volume))
                    Text(String(describing: viewModel.stats?.beta))
                    Text(String(describing: viewModel.stats?.day5ChangePercent))
                    Text(String(describing: viewModel.stats?.day30ChangePercent))
                    Text(String(describing: viewModel.stats?.month3ChangePercent))
                    Text(String(describing: viewModel.stats?.year1ChangePercent))
                    Text(String(describing: viewModel.stats?.year2ChangePercent))
//                    Text(String(describing: viewModel.stats?.year5ChangePercent))
//                    Text(String(describing: viewModel.stats?.week52low))
                }
                
            case .error(let error):
                Text(error)
            case .loading:
                Text("loading...")
                    .onAppear { viewModel.load() }
            default:
                Text("Default")
                
            }
            
        }.frame(width: UIScreen.main.bounds.size.width, height: 200, alignment: .center)
            .padding(.horizontal)
        
        
    }
}

struct CompanyTechnicalData_Previews: PreviewProvider {
    static var previews: some View {
        CompanyTechnicalDataView()
    }
}
