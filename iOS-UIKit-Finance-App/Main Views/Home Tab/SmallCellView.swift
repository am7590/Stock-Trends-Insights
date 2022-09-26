//
//  SectorView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/24/22.
//

import SwiftUI

struct SmallCellView: View {
    let title: String
    let count: String
    let percentChange: String?
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
            
            if let percentChange = percentChange {
                HStack {
                    Spacer()
                    HStack {
                        Image(systemName: isPositive ? "chevron.up" : "chevron.down")
                        Text(percentChange)
                            .font(.subheadline)
  
                    }
                    .frame(maxWidth: .infinity)
                    .padding(4)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill((isPositive ? Color.green : Color.red).opacity(0.4))
                        )
                    
                    Spacer()
                }
            } else {
                HStack {
                    Spacer()
                    HStack {
                        Image(systemName: isPositive ? "chevron.up" : "chevron.down")
                        Text(count)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(4)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill((isPositive ? Color.green : Color.red).opacity(0.4))
                        )
                    
                    Spacer()
                }.padding(.bottom, 8)
            }
        }
        .foregroundColor(Color.black)
        // .padding(.vertical, 22)
        .padding(.horizontal, 18)
        
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(width: 150, height: 100)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.secondary, lineWidth: 2)
        )
        .background(Color(uiColor: UIColor.systemGray5))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        
    }
}

