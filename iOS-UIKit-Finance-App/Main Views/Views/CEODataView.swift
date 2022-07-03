//
//  CEODataView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/30/22.
//

import SwiftUI

struct CEODataView: View {
    @StateObject var viewModel = CEODataViewModel()
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loaded:
                
                Color.pink
                
                VStack {
                    
                    Text(String(describing: viewModel.ceoCompensation?.name))
                    Text(String(describing: viewModel.ceoCompensation?.salary))
                    Text(String(describing: viewModel.ceoCompensation?.bonus))
                    Text(String(describing: viewModel.ceoCompensation?.stockAwards))
                    Text(String(describing: viewModel.ceoCompensation?.optionAwards))
                    Text(String(describing: viewModel.ceoCompensation?.total))
                    
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

struct CEODataView_Previews: PreviewProvider {
    static var previews: some View {
        CEODataView()
    }
}
