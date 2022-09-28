//
//  SectorsView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/24/22.
//

import SwiftUI

struct SectorsView: View {
    
    @ObservedObject var viewModel = SectorsViewModel()
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                Text("Loading...")
            case .error(let error):
                Text("Error loading data: \(error)")
            default:
                VStack(alignment: .leading, spacing: 16) {
                    HStack{
                        
                        Text("Sector Performance")
                            .font(.largeTitle.bold())
                        //.foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding(.vertical, 5)
                    
                    ScrollView(.horizontal) {
                        VStack(alignment: .leading, spacing: 16) {
                            
                            
                            HStack {
                                if let firstSectorList = viewModel.sectors?[0] {
                                    ForEach(firstSectorList, id: \.symbol) { sector in
                                        SmallCellView(title: sector.name, count: String(sector.performance), percentChange: nil, image: sector.icon, isPositive: sector.performanceIsPositive)
                                        
                                    }
                                }
                                
                            }
                            
                            HStack {
                                if let secondSectorList = viewModel.sectors?[1] {
                                    ForEach(secondSectorList, id: \.symbol) { sector in
                                        SmallCellView(title: sector.name, count: String(sector.performance), percentChange: nil, image: sector.icon, isPositive: sector.performanceIsPositive)
                                    }
                                }
                            }
                        }
                        
                    }
                    
                }
            }
            
        }.onAppear {
            viewModel.load()
        }
        .frame(height: 300)
        .padding(.horizontal)
    }
}
