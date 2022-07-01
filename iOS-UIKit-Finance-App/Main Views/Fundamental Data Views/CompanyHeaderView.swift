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
        
        switch viewModel.state {
        case .loaded:
            
            ZStack {
                Color.green
                VStack(spacing: 8) {
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
            }.frame(width: UIScreen.main.bounds.size.width, height: 200, alignment: .center)
                .padding(.horizontal)
        case .error(let error):
            Text(error)
        case .loading:
            Text("loading...")
                .onAppear { viewModel.load() }
        default:
            Text("Default")
            
        }
    
        
        
        
    }
}

//struct CompanyHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        CompanyHeaderView()
//    }
//}



@MainActor class CompanyHeaderViewModel: ObservableObject {
    let service = IEXApiService()
    let stock: String = "TSLA"
    
    enum State {
        case loading
        case loaded
        case empty(String)
        case error(String)
    }
    
    @Published var logo: Logo?
    @Published var companyInfo: CompanyInfo?
    @Published var state: State = .loading

    
    func load() {
        
        Task(priority: .medium) {
            let result = await service.getLogo(stock: stock)
            switch result {
            case .success(let response):
                print(response.url ?? "")
                self.logo = response
                
            case .failure(let error):
                self.logo = nil
            }
            state = self.logo == nil || self.companyInfo == nil ? .loading : .loaded
        }
        
        Task(priority: .medium) {
            let result = await service.getCompanyInfo(stock: stock)
            switch result {
            case .success(let response):
                print(response)
                self.companyInfo = response
                
            case .failure(let error):
                self.companyInfo = nil
            }
            state = self.logo == nil || self.companyInfo == nil ? .loading : .loaded
        }

    }
}
