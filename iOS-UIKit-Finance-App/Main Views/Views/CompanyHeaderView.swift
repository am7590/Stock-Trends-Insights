//
//  CompanyHeaderView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/29/22.
//

import SwiftUI

struct CompanyHeaderView: View {
    
    @StateObject var viewModel = CompanyHeaderViewModel()
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loaded:
                
                Color.green
                VStack {
                    Text(String(describing: viewModel.logo?.url))
                    Text(String(describing: viewModel.companyInfo?.companyName))
                    Text(String(describing: viewModel.companyInfo?.address))
                    Text(String(describing: viewModel.companyInfo?.city))
                    Text(String(describing: viewModel.companyInfo?.employees))
                    Text(String(describing: viewModel.companyInfo?.industry))
                    Text(String(describing: viewModel.companyInfo?.sector))
                    Text(String(describing: viewModel.companyInfo?.exchange))
                    Text(String(describing: viewModel.companyInfo?.description))
                    
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

//struct CompanyHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        CompanyHeaderView()
//    }
//}



