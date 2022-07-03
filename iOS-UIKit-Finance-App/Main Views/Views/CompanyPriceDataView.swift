//
//  CompanyPriceData.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/29/22.
//

import SwiftUI

struct CompanyPriceDataView: View {
    @StateObject var viewModel = CompanyTechnicalDataViewModel()
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loaded:
                
                Color.red
                
                VStack {
                    Text(String(describing: viewModel.stats?.companyName))
     
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

struct CompanyPriceData_Previews: PreviewProvider {
    static var previews: some View {
        CompanyPriceDataView()
    }
}
