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
                                        SectorView(title: sector.name, count: String(sector.performance), image: sector.icon, isPositive: sector.performanceIsPositive)
                                    }
                                }
                                
                            }
                            
                            HStack {
                                if let secondSectorList = viewModel.sectors?[1] {
                                    ForEach(secondSectorList, id: \.symbol) { sector in
                                        SectorView(title: sector.name, count: String(sector.performance), image: sector.icon, isPositive: sector.performanceIsPositive)
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
        .frame(height: 200)
        .padding(.horizontal)
    }
    
    struct SectorsView_Previews: PreviewProvider {
        static var previews: some View {
            SectorsView()
        }
    }
}


struct SectorView: View {
    let title: String
    let count: String
    let image: String
    let isPositive: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            
            HStack{
                Image(systemName: image)
                    .font(.caption.bold())
                    .foregroundColor(Color.white)
                    .padding(6)
                    .background(Color.secondary)
                    .cornerRadius(8)
                
                Text(title)
                
            }
            
            HStack {
                Spacer()
                HStack {
                    Image(systemName: isPositive ? "chevron.up" : "chevron.down")
                    Text(count)
                    
                }.padding(4)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill((isPositive ? Color.green : Color.red).opacity(0.4))
                    )
                
                Spacer()
            }.padding(.bottom, 8)
            
        }
        .foregroundColor(Color.black)
        // .padding(.vertical, 22)
        .padding(.horizontal, 18)
        
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(width: 170, height: 100)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.secondary, lineWidth: 2)
        )
        .background(Color(uiColor: UIColor.systemGray5))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        
    }
}
